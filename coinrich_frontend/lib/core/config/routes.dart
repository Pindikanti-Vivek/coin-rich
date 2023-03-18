import 'package:coinrich_frontend/presentation/coin/coin_bindings.dart';
import 'package:coinrich_frontend/presentation/coin/coin_screen.dart';
import 'package:coinrich_frontend/presentation/home/home_screen.dart';
import 'package:coinrich_frontend/presentation/login/login_bindings.dart';
import 'package:coinrich_frontend/presentation/login/login_screen.dart';
import 'package:get/get.dart';

List<GetPage> routes = [
  GetPage(
    name: "/login",
    page: () => const LoginScreen(),
    binding: LoginBindings(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: "/home",
    page: () => const HomeScreen(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: "/coin",
    page: () => const CoinScreen(),
    binding: CoinBindings(),
    transition: Transition.fadeIn,
  ),
];
