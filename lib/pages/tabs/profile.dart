import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_flutter/services/functions/authFunctions.dart';
import 'package:demo_flutter/utils/string_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _handleSignOut() async {
    final bool? confirmSignOut = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Sign Out', style: GoogleFonts.poppins()),
          content: Text('Are you sure you want to sign out?',
              style: GoogleFonts.poppins()),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: GoogleFonts.poppins()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Sign Out',
                  style: GoogleFonts.poppins(color: Colors.redAccent)),
              onPressed: () async {
                await handleSignOut(context);
              },
            ),
          ],
        );
      },
    );

    if (confirmSignOut == true) {
      // User confirmed sign out, handle the rest of the logic here
      // For example, you can call FirebaseAuth.instance.signOut()
      // and navigate to the login screen.
      print('User confirmed sign out');
      // Add your sign-out logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color onPrimaryColor = theme.colorScheme.onPrimary;
    final Color secondaryColor = theme.colorScheme.secondary;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(FireStoreConstants.COLLECTION_USERS)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: primaryColor),
                const SizedBox(height: 16),
                Text('Loading profile...',
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: Colors.grey[700])),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorState('Error: ${snapshot.error}', theme);
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _buildErrorState('User data not found.', theme,
              icon: Icons.person_off_outlined);
        }

        final userData = snapshot.data!.data()!;
        final String name = userData[FireStoreConstants.NAME] ?? 'N/A';
        final String email = userData[FireStoreConstants.EMAIL] ?? 'N/A';
        final int age = userData[FireStoreConstants.AGE] ?? 0;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor.withOpacity(0.1),
                secondaryColor.withOpacity(0.1),
                theme.colorScheme.background
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: primaryColor,
                  child: Icon(Icons.person, size: 50, color: onPrimaryColor),
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome, $name!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 32),
                _buildInfoCard(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: email,
                  theme: theme,
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  icon: Icons.cake_outlined,
                  title: 'Age',
                  value: age.toString(),
                  theme: theme,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: Icon(Icons.logout, color: onPrimaryColor),
                  label: Text('Sign Out',
                      style: GoogleFonts.poppins(
                          color: onPrimaryColor, fontWeight: FontWeight.w500)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: GoogleFonts.poppins(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _handleSignOut,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message, ThemeData theme,
      {IconData icon = Icons.error_outline}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.redAccent, size: 70),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 18, color: Colors.redAccent.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon,
      required String title,
      required String value,
      required ThemeData theme}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 30, color: theme.colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
