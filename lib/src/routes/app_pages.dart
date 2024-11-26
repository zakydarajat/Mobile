import 'package:get/get.dart';
import 'package:myapp/src/view/screen/home_screen.dart';
import 'package:myapp/src/view/screen/profile_screen.dart';
import 'package:myapp/src/bindings/profile_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
