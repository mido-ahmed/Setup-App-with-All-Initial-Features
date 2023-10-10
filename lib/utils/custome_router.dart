import 'package:go_router/go_router.dart';
import 'package:spacepictures/ui/screens/home.dart';
import 'package:spacepictures/ui/screens/nasa.dart';
import 'package:spacepictures/utils/route_constant.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: news,
        builder: (context, state) => const NasaScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return const HomeScreen();
    },
  );
}
