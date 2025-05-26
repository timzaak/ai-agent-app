import 'package:app/pages/index_tab/my.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'pages/account/login.dart';
import 'package:app/pages/index_tab/device.dart'; // Added import
import 'package:app/pages/index_tab/device_qr_scan.dart'; // Added import

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/a',
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
          path: '/a',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenA();
          },
          routes: <RouteBase>[
            // The details screen to display stacked on the inner Navigator.
            // This will cover screen A but not the application shell.
            GoRoute(
              path: 'details',
              builder: (BuildContext context, GoRouterState state) {
                return const DetailsScreen(label: 'A');
              },
            ),
          ],
        ),

        /// Displayed when the second item in the the bottom navigation bar is
        /// selected. Changed from /b to /device for DevicePage
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
            label: 'A Screen',
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
    if (location.startsWith('/a')) {
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
        GoRouter.of(context).go('/a');
      case 1:
        GoRouter.of(context).go('/device'); // Changed /b to /device
      case 2:
        GoRouter.of(context).go('/my');
    }
  }
}

/// The first screen in the bottom navigation bar.
class ScreenA extends StatelessWidget {
  /// Constructs a [ScreenA] widget.
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen A'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/a/details');
              },
              child: const Text('View A details'),
            ),
          ],
        ),
      ),
    );
  }
}

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