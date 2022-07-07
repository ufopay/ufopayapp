import 'package:ufopayapp/home/home.dart';
import 'package:ufopayapp/login/login.dart';
import 'package:ufopayapp/about/about.dart';
import 'package:ufopayapp/profile/profile.dart';
import 'package:ufopayapp/add_card/add_card.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/about': (context) => const AboutScreen(),
  '/login': (context) => const LoginScreen(),
  '/add_card': (context) => AddCardScreen(),
  '/profile': (context) => const ProfileScreen(),
};
