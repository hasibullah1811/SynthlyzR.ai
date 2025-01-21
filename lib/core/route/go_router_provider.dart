import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synthlyzr/core/route/route_name.dart';
import 'package:synthlyzr/demo_screen.dart';
import 'package:synthlyzr/features/login/presentation/screens/login_screen.dart';
import 'package:synthlyzr/features/signup/signup_screen.dart';
import 'package:synthlyzr/features/spreadsheet/presentation/screens/spreadsheet_preview_screen.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: "/login",
      routes: [
        GoRoute(
          path: "/login",
          name: loginRoute,
          builder: (context, state) => const LoginScreenMain(),
        ),
        GoRoute(
          path: "/signup",
          name: signUpRoute,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: "/demo",
          name: demoRoute,
          builder: (context, state) => SpreadsheetEditorScreen(),
        ),
        GoRoute(
          path: '/preview',
          name: previewRoute,
          builder: (context, state) => SpreadsheetPreviewScreen(),
        ),
      ],
    );
  },
);
