import 'pages/account/login_page.dart';
import 'pages/account/password_page.dart';
import 'pages/index_tab/my_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'pages/index_tab/device_page.dart';
import 'pages/index_tab/device_qr_scan_page.dart';

import 'pages/account/password_type.dart';
import 'pages/index_tab/index_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  observers: [FlutterSmartDialog.observer],
  debugLogDiagnostics: kDebugMode,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/index', // Changed from '/a'
          builder: (BuildContext context, GoRouterState state) {
            return const IndexPage(); // Use IndexPage
          },
        ),

        GoRoute(
          path: '/device', // Changed path to /device
          name: DevicePage.sName, // Added name for the route
          builder: (BuildContext context, GoRouterState state) {
            return const DevicePage(); // Changed to DevicePage
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/qr_scan',
              name: DeviceQrScanPage.sName,
              builder: (BuildContext context, GoRouterState state) {
                return const DeviceQrScanPage();
              },
            ),
          ],
        ),

        GoRoute(
          path: '/my',
          name: MyPage.sName,
          builder: (BuildContext context, GoRouterState state) {
            return const MyPage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'details',
              builder: (BuildContext context, GoRouterState state) {
                return const DetailsScreen(label: 'C');
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: LoginPage.sName, // Assuming LoginPage has sName
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/password',
      name: ChangePasswordPage.sName,
      builder: (BuildContext context, GoRouterState state) {
        final type = state.extra as ChangePasswordType?;
        if (type == null) {
          throw ArgumentError(
              'ChangePasswordType must be provided when navigating to PasswordPage');
        }
        return ChangePasswordPage(type: type);
      },
    ),
  ],
);


/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Changed label to 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices), // Changed icon for Devices
            label: 'Devices', // Changed label for Devices
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_rounded),
            label: 'My',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/index')) { // Changed from '/a'
      return 0;
    }
    if (location.startsWith('/device')) { // Changed /b to /device
      return 1;
    }
    if (location.startsWith('/my')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/index'); // Changed from '/a'
        break;
      case 1:
        GoRouter.of(context).go('/device'); // Changed /b to /device
        break;
      case 2:
        GoRouter.of(context).go('/my');
        break;
    }
  }
}

// ScreenA is removed as IndexPage is now used for '/a'.
// If ScreenA and its 'details' route were used elsewhere, they should be kept or refactored.
// For this task, assuming ScreenA is fully replaced by IndexPage.

/// The second screen in the bottom navigation bar.
class ScreenB extends StatelessWidget {
  /// Constructs a [ScreenB] widget.
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen B'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/b/details');
              },
              child: const Text('View B details'),
            ),
            TextButton(onPressed: () {
              GoRouter.of(context).push('/login');
            }, child: const Text('go Login'))
          ],
        ),
      ),
    );
  }
}

/// The third screen in the bottom navigation bar.
class ScreenC extends StatelessWidget {
  /// Constructs a [ScreenC] widget.
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen C'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/c/details');
              },
              child: const Text('View C details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A, B or C screen.
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}