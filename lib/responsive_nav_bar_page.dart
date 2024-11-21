import 'package:flutter/material.dart';
import 'package:mobile_app/preloader.dart'; // Ensure correct import
import 'package:mobile_app/profile_page.dart'; // Import the ProfilePage file
import 'vote_page.dart'; // Import the file containing VotePage
import 'package:url_launcher/url_launcher.dart'; // To handle URL launching

class ResponsiveNavBarPage extends StatelessWidget {
  ResponsiveNavBarPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // Match the background color from vote_page.dart
        foregroundColor: Colors.black, // Match the text and icon color from vote_page.dart
        elevation: 0,
        titleSpacing: 0,
        leading: isLargeScreen
            ? null
            : IconButton(
                icon: const Icon(Icons.menu, color: Colors.black), // Match the icon color
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Litex Vote",
                style: TextStyle(
                  color: Colors.deepOrangeAccent, // Match the text color from vote_page.dart
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              if (isLargeScreen) Expanded(child: _navBarItems())
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent, // Transparent background
              child: _ProfileIcon(),
            ),
          ),
        ],
      ),
      drawer: isLargeScreen ? null : _drawer(),
      body: const VotePage(), // Set VotePage as the body
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue), // Icon for the Facebook page
              title: const Text('Litex Village Facebook Page'),
              onTap: () => _launchURL(Uri.parse('https://www.facebook.com/profile.php?id=100093287281945')), // Update with actual URL
            ),
            ListTile(
              leading: const Icon(Icons.how_to_vote, color: Colors.green), // Icon for the View Candidates option
              title: const Text('View Candidates'),
              onTap: () => _launchURL(Uri.parse('http://192.168.193.249/Website/index.php')), // Update with actual URL
            ),
          ],
        ),
      );

  Widget _navBarItems() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
              child: Text(
                'Menu Item Placeholder', // Remove or replace this as needed
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

enum Menu { account, signOut }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon(); // Remove the key parameter

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      icon: const Icon(Icons.person, color: Colors.black), // Match the icon color
      offset: const Offset(0, 40),
      onSelected: (Menu item) {
        switch (item) {
          case Menu.account:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
            break;
          case Menu.signOut:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PreloaderIntro()),
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.account,
          child: Text('Account'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.signOut,
          child: Text('Sign Out'),
        ),
      ],
    );
  }
}
