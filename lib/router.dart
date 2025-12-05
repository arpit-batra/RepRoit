import 'package:go_router/go_router.dart';
import 'package:rep_roit/features/auth/presentation/pages/sign_in_page.dart';
import 'package:rep_roit/features/auth/presentation/pages/sign_up_page.dart';
import 'package:rep_roit/features/home/presentation/pages/home_page.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'sign-in',
        builder: (context, state) => SignInPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'sign-up',
        builder: (context, state) => SignUpPage(),
      ),
    ],
  );
}
