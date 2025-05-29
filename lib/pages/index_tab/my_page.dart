import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../account/password_page.dart';
import '../account/password_type.dart';
import '../../l10n/app_localizations.dart';

class MyPage extends StatelessWidget {
  static const sName = 'my'; // For named navigation

  const MyPage({super.key});

  Future<void> _logout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    SmartDialog.showLoading();
    try {
      await FirebaseAuth.instance.signOut();
      SmartDialog.dismiss();
      // Navigate to login screen. Ensure 'login' is a defined route name.
      // context.goNamed(LoginPage.sName); // If LoginPage.sName is available
      context.go('/login'); // Or directly use the path
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast(l10n.logoutFailed(e.toString()));
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    // Show confirmation dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteAccount),
          content: Text(l10n.deleteAccountConfirm),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      SmartDialog.showLoading(msg: l10n.deletingAccount);
      try {
        await FirebaseAuth.instance.currentUser?.delete();
        SmartDialog.dismiss();
        SmartDialog.showToast(l10n.accountDeletedSuccess);
        // Navigate to login screen
        // context.goNamed(LoginPage.sName);
        context.go('/login'); 
      } on FirebaseAuthException catch (e) {
        SmartDialog.dismiss();
        if (e.code == 'requires-recent-login') {
          SmartDialog.showToast(l10n.requiresRecentLogin);
          // Optionally, force re-authentication here
        } else {
          SmartDialog.showToast(l10n.unexpectedError(e.message ?? ''));
        }
      } catch (e) {
        SmartDialog.dismiss();
        SmartDialog.showToast(l10n.unexpectedError(e.toString()));
      }
    }
  }

  void _viewUserAgreement(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Placeholder: In a real app, navigate to User Agreement page or open URL
    SmartDialog.showToast('Navigate to ${l10n.userAgreement} (Not Implemented)');
    // Example: context.go('/user-agreement');
    // Or using url_launcher: launchUrl(Uri.parse('https://example.com/user-agreement'));
  }

  void _viewPrivacyPolicy(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Placeholder: In a real app, navigate to Privacy Policy page or open URL
    SmartDialog.showToast('Navigate to ${l10n.privacyPolicy} (Not Implemented)');
    // Example: context.go('/privacy-policy');
    // Or using url_launcher: launchUrl(Uri.parse('https://example.com/privacy-policy'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myAccount),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.policy),
            title: Text(l10n.userAgreement),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _viewUserAgreement(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(l10n.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _viewPrivacyPolicy(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(l10n.changePassword),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              GoRouter.of(context).pushNamed(
                ChangePasswordPage.sName,
                extra: ChangePasswordType.ResetPassword,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(l10n.logout),
            onTap: () => _logout(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(l10n.deleteAccount, style: const TextStyle(color: Colors.red)),
            onTap: () => _deleteAccount(context),
          ),
        ],
      ),
    );
  }
}
