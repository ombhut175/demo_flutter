import 'package:flutter/material.dart'; // Changed from cupertino to material for more general widgets

class Settings extends StatelessWidget {
  //note this is a dummy screen

  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'DUMMY PAGE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildSettingButton(context, 'Notifications', Icons.notifications_none, () {}),
                  const SizedBox(width: 10),
                  _buildSettingButton(context, 'Account', Icons.account_circle_outlined, () {}),
                  const SizedBox(width: 10),
                  _buildSettingButton(context, 'Appearance', Icons.palette_outlined, () {}),
                  const SizedBox(width: 10),
                  _buildSettingButton(context, 'Privacy', Icons.lock_outline, () {}),
                  const SizedBox(width: 10),
                  _buildSettingButton(context, 'About', Icons.info_outline, () {}),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'More settings content here...',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingButton(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Theme.of(context).primaryColor),
      label: Text(title, style: TextStyle(color: Theme.of(context).primaryColor)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
