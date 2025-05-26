import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// Assuming your login page route name is 'login' as defined in your GoRouter setup
// import 'package:app/pages/account/login.dart'; 

class MyPage extends StatelessWidget {
  static const sName = 'my'; // For named navigation

  const MyPage({super.key});

  Future<void> _logout(BuildContext context) async {
    SmartDialog.showLoading();
    try {
      await FirebaseAuth.instance.signOut();
      SmartDialog.dismiss();
      // Navigate to login screen. Ensure 'login' is a defined route name.
      // context.goNamed(LoginPage.sName); // If LoginPage.sName is available
      context.go('/login'); // Or directly use the path
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast('Logout failed: $e');
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    // Show confirmation dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      SmartDialog.showLoading(msg: 'Deleting account...');
      try {
        await FirebaseAuth.instance.currentUser?.delete();
        SmartDialog.dismiss();
        SmartDialog.showToast('Account deleted successfully.');
        // Navigate to login screen
        // context.goNamed(LoginPage.sName);
        context.go('/login'); 
      } on FirebaseAuthException catch (e) {
        SmartDialog.dismiss();
        if (e.code == 'requires-recent-login') {
          SmartDialog.showToast('This operation is sensitive and requires recent authentication. Please log in again before retrying.');
          // Optionally, force re-authentication here
        } else {
          SmartDialog.showToast('Failed to delete account: ${e.message}');
        }
      } catch (e) {
        SmartDialog.dismiss();
        SmartDialog.showToast('An unexpected error occurred: $e');
      }
    }
  }

  void _viewUserAgreement(BuildContext context) {
    // Placeholder: In a real app, navigate to User Agreement page or open URL
    SmartDialog.showToast('Navigate to User Agreement (Not Implemented)');
    // Example: context.go('/user-agreement');
    // Or using url_launcher: launchUrl(Uri.parse('https://example.com/user-agreement'));
  }

  void _viewPrivacyPolicy(BuildContext context) {
    // Placeholder: In a real app, navigate to Privacy Policy page or open URL
    SmartDialog.showToast('Navigate to Privacy Policy (Not Implemented)');
    // Example: context.go('/privacy-policy');
    // Or using url_launcher: launchUrl(Uri.parse('https://example.com/privacy-policy'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.policy),
            title: const Text('User Agreement'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _viewUserAgreement(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _viewPrivacyPolicy(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
            onTap: () => _deleteAccount(context),
          ),
        ],
      ),
    );
  }
}
