import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Election App',
      debugShowCheckedModeBanner: false,
      home: VotePage(),
    );
  }
}

class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => VotePageState();
}

class VotePageState extends State<VotePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  int availableVotes = 0;
  final Logger logger = Logger();

  Map<String, String?> selectedVotes = {};

  List<String> positions = [];
  Map<String, List<String>> candidates = {};

  String electionName = '';
  String startDateTime = '';
  String endDateTime = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _clearSelections();
    _fetchPositionsAndCandidates();
    _fetchAvailableVotes();
    _fetchElectionDetails();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.index != _currentIndex) {
      _tabController.index = _currentIndex;
    }
  }

void _goToReviewTab() {
  if (availableVotes == 0) {
    if (mounted) {
      Fluttertoast.showToast(
        msg: 'You have no available votes to cast.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    return;
  }

  if (_validateSelections()) {
    setState(() {
      _currentIndex = 1;
      _tabController.animateTo(_currentIndex);
    });
  } else {
    if (mounted) {
      Fluttertoast.showToast(
        msg: 'Please select a candidate for all required positions.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}

void _showConfirmationDialog() {
  if (availableVotes == 0) {
    if (mounted) {
      Fluttertoast.showToast(
        msg: 'You have no available votes to cast.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    return;
  }

  if (!mounted) return; // Check if the widget is still mounted

  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.bottomSlide,
    title: 'Confirm Vote',
    desc: 'Are you sure you want to submit your vote?',
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      setState(() {
      });
      _submitVote(); // Proceed to submit the vote
    },
    btnOkText: 'SUBMIT',
    btnCancelText: 'CANCEL',
  ).show();
}

Future<void> _submitVote() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'User not logged in. Please verify OTP first.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      return;
    }

    // Filter out only valid selected votes with position ID -> candidate ID
    final validVotes = Map<String, String>.fromEntries(
      selectedVotes.entries
        .where((entry) => entry.value != null && entry.value!.isNotEmpty)
        .map((entry) => MapEntry(entry.key, entry.value!)) // position_id -> candidate_id
    );

    if (validVotes.isEmpty) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'No candidates selected. Please select candidates for each position.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      return;
    }

    // Prepare the vote data in the required format
    final voteData = {
      'action': 'submit_vote',
      'user_id': userId,
      'votes': validVotes, // position_id -> candidate_id mapping
    };

    // Log the data being sent for debugging
    logger.d("Sending data: ${json.encode(voteData)}");

    // Send the vote data to the server
    final response = await http.post(
      Uri.parse('http://192.168.193.249/Desktop/api.php?action=submit_vote'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(voteData),
    );

    // Handle the response from the server
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        setState(() {
          availableVotes--; // Decrease available votes after submission
        });

        _clearSelections(); // Clear selections after successful vote submission

        if (mounted) {
          // Set the current index to 0 for the Select Tab
          setState(() {
            _currentIndex = 0;
            _tabController.animateTo(_currentIndex); // Go directly to the Select Tab
          });

          // Navigate to the Thank You Page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThankYouPage()),
          );
        }
      } else {
        logger.e("Vote submission failed: ${responseData['message'] ?? 'Unknown error'}");

        if (mounted) {
          Fluttertoast.showToast(
            msg: responseData['message'] ?? 'Vote submission failed.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      }
    } else {
      logger.e("Error response: ${response.body}");

      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Server error. Please try again. Status code: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  } catch (e) {
    logger.e("Exception: $e");

    if (mounted) {
      Fluttertoast.showToast(
        msg: 'Error submitting vote. Please try again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}






Future<void> _clearSelections() async {
  final prefs = await SharedPreferences.getInstance();

  // Clear selections dynamically based on current positions
  for (var position in positions) {
    await prefs.remove(position);
  }

  if (mounted) {
    setState(() {
      selectedVotes.clear(); // Clear all selected votes
    });
  }
}


Future<void> _saveSelection(String position, String? candidate) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(position, candidate ?? '');
}

bool _validateSelections() {
  // Check if each position has a selected candidate
  return positions.every((position) => selectedVotes[position] != null);
}


Future<void> _fetchPositionsAndCandidates() async {
  try {
    // Fetch positions
    final response = await http.get(Uri.parse(
        'http://192.168.193.249/Desktop/api.php?action=get_positions'));
    if (response.statusCode == 200) {
      final List<dynamic> positionList = json.decode(response.body);
      setState(() {
        positions = positionList
            .map((pos) => pos['position_name'] as String)
            .toList();
        for (var position in positions) {
          selectedVotes[position] = null;
        }
      });
    } else {
      throw Exception('Failed to load positions');
    }

    // Fetch candidates
    final candidateResponse = await http.get(Uri.parse(
        'http://192.168.193.249/Desktop/api.php?action=get_candidates'));
    if (candidateResponse.statusCode == 200) {
      logger.d('Candidate response: ${candidateResponse.body}');
      final Map<String, dynamic> candidateMap =
          json.decode(candidateResponse.body);

      setState(() {
        candidates = candidateMap.map((key, value) {
          if (value is List) {
            return MapEntry(
                key,
                value.map((item) => item['name'] as String).toList()); // Only names
          } else {
            return MapEntry(key, []);
          }
        });
      });
    } else {
      throw Exception('Failed to load candidates');
    }
  } catch (e) {
    logger.e(e);
    Fluttertoast.showToast(
      msg: 'Error fetching data. Please try again.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}



  Future<void> _fetchAvailableVotes() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(
        'user_id');

    if (userId != null) {
      try {
        final response = await http.get(Uri.parse(
            'http://192.168.193.249/Desktop/api.php?action=get_available_votes&user_id=$userId'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            availableVotes =
                data['available_votes'] ?? 0; 
          });
        } else {
      
          Fluttertoast.showToast(
            msg: 'Failed to fetch available votes.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        // Handle exceptions
        Fluttertoast.showToast(
          msg: 'Error fetching available votes. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  Future<void> _fetchElectionDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.193.249/Desktop/api.php?action=get_election_details'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          electionName = data['election_name'] as String;

          
          final DateFormat inputFormat = DateFormat("MMMM d, yyyy h:mm a");

          
          DateTime startDateTimeParsed =
              inputFormat.parse(data['start_datetime'] as String);
          DateTime endDateTimeParsed =
              inputFormat.parse(data['end_datetime'] as String);

          
          final DateFormat outputFormat = DateFormat("MMMM d, yyyy h:mm a");
          startDateTime = outputFormat.format(startDateTimeParsed);
          endDateTime = outputFormat.format(endDateTimeParsed);
        });
      } else {
        throw Exception('Failed to load election details');
      }
    } catch (e) {
      logger.e(e); 
      Fluttertoast.showToast(
        msg: 'Error fetching election details. Please try again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          titleSpacing: 0,
          toolbarHeight: 48,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            color: Colors.grey[200],
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'SELECT'),
              Tab(text: 'REVIEW'),
            ],
            onTap: (index) {
              if (index != _currentIndex) {
                _tabController.index = _currentIndex;
              }
            },
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFFFFF), 
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                electionName.isNotEmpty
                    ? electionName
                    : 'Election Name', 
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          'Open until $startDateTime until $endDateTime',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Instructions: Select a candidate for each position. Click "Continue" to review your choices before submitting your vote.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          height: 20,
                          thickness: 3,
                          indent: 20,
                          endIndent: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 20),
                        
                        ...positions.map((position) {
                          return ElectionSection(
                            position: position,
                            candidates: candidates[position] ?? [],
                            selectedCandidate: selectedVotes[position],
                            onSelectionChanged: (value) {
                              setState(() {
                                selectedVotes[position] = value;
                                _saveSelection(position, value);
                              });
                            },
                            isLastSection: position == positions.last,
                          );
                        }),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Selections:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        ...positions.map((position) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 16), 
                            child: CandidateReviewCard(
                              position: position,
                              selectedCandidate: selectedVotes[position],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
bottomNavigationBar: BottomAppBar(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentIndex == 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Available Votes: $availableVotes',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        // Display BACK button only in REVIEW tab
        if (_currentIndex == 1)
          OutlinedButton(
            onPressed: () {
              setState(() {
                _currentIndex = 0;
                _tabController.animateTo(_currentIndex);
              });
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('BACK', style: TextStyle(color: Colors.grey)),
          ),
        
        // CONTINUE button on SELECT tab and SUBMIT button on REVIEW tab
        ElevatedButton(
          onPressed: _currentIndex == 0
              ? (availableVotes > 0 && _validateSelections()
                  ? _goToReviewTab
                  : null)
              : _showConfirmationDialog, // Always active in REVIEW tab
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            backgroundColor: const Color(0xFFDAA520),
          ),
          child: Text(
            _currentIndex == 0
                ? (availableVotes > 0 ? 'CONTINUE' : 'VOTED')
                : 'SUBMIT',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  ),
)

    );
  }
}

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank You'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Thanks for your voting!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ElectionSection extends StatefulWidget {
  final String position;
  final List<String> candidates;
  final String? selectedCandidate;
  final ValueChanged<String?> onSelectionChanged;
  final bool isLastSection; 

  const ElectionSection({
    required this.position,
    required this.candidates,
    required this.selectedCandidate,
    required this.onSelectionChanged,
    super.key,
    required this.isLastSection, 
  });

  @override
  ElectionSectionState createState() => ElectionSectionState();
}

class ElectionSectionState extends State<ElectionSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Candidates for ${widget.position}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        ...widget.candidates.map((candidate) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.blue),
            ),
            child: RadioListTile<String>(
              title: Text(candidate),
              value: candidate,
              groupValue: widget.selectedCandidate,
              onChanged: widget.onSelectionChanged,
              activeColor: Colors.blue,
            ),
          );
        }),
        if (!widget.isLastSection) 
          const SizedBox(height: 24),
      ],
    );
  }
}

class CandidateReviewCard extends StatelessWidget {
  final String position;
  final String? selectedCandidate;

  const CandidateReviewCard({
    required this.position,
    required this.selectedCandidate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your $position',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.blue),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCandidate ?? 'No selection made',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.check_circle_outline, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
