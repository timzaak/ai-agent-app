import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';

import '../account/password_page.dart';
import '../account/password_type.dart';
import '../../l10n/app_localizations.dart';
import '../../services/version_service.dart';

class MyPage extends StatefulWidget {
  static const sName = 'my';

  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _version = '';
  final _versionService = VersionService();

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    if (!kIsWeb) {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
      });
    }
  }

  Future<void> _checkVersion() async {
    if (!kIsWeb) {
      await _versionService.checkVersion();
      if (_versionService.hasNewVersion) {
        await _versionService.showUpgradeDialog();
      } else {
        SmartDialog.showToast('当前已是最新版本');
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    SmartDialog.showLoading();
    try {
      await FirebaseAuth.instance.signOut();
      SmartDialog.dismiss();
      context.go('/login');
    } catch (e) {
      SmartDialog.dismiss();
      SmartDialog.showToast(l10n.logoutFailed(e.toString()));
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
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
        context.go('/login');
      } on FirebaseAuthException catch (e) {
        SmartDialog.dismiss();
        if (e.code == 'requires-recent-login') {
          SmartDialog.showToast(l10n.requiresRecentLogin);
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
    SmartDialog.showToast('Navigate to ${l10n.userAgreement} (Not Implemented)');
  }

  void _viewPrivacyPolicy(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    SmartDialog.showToast('Navigate to ${l10n.privacyPolicy} (Not Implemented)');
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
          if (!kIsWeb) ListTile(
            leading: const Icon(Icons.system_update),
            title: const Text('版本信息'),
            subtitle: Text(_version),
            trailing: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _checkVersion,
                ),
                if (_versionService.hasNewVersion)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
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
