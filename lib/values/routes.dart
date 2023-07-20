import 'package:get/get.dart';
import '../view/view.dart';
import 'strings.dart';

class AppRoutes {
  static name(RouteName name) => _routeName(name);

  static List<GetPage> get routes => _appRoutes();

  static String _routeName(RouteName name) {
    switch (name) {
      case RouteName.welcome:
        return '/';
      case RouteName.home:
        return '/home';
      case RouteName.unknown:
        return '/unknown';
      case RouteName.login:
        return '/login';
      case RouteName.forgotPassword:
        return '/forgotPassword';
      case RouteName.register:
        return '/register';
      case RouteName.setNewPassword:
        return '/setNewPassword';
      case RouteName.createAccount:
        return '/createAccount';
      case RouteName.redFlag:
        return '/redFlag';
      case RouteName.userDetails:
        return '/userDetails';
      case RouteName.userBusiness:
        return '/userBusiness';
      case RouteName.userSecurity:
        return '/userSecurity';
      case RouteName.userBank:
        return '/userBank';
      case RouteName.portfolio:
        return '/portfolio';
      case RouteName.receipt:
        return '/receipt';
      case RouteName.financial:
        return '/financial';
      case RouteName.calculator:
        return '/calculator';
      case RouteName.faq:
        return '/faq';
      default:
        return '/unknown';
    }
  }

  static List<GetPage> _appRoutes() {
    return [
      GetPage(
          name: _routeName(RouteName.unknown),
          page: () => const UnknownRoutePage()),
      GetPage(name: _routeName(RouteName.welcome), page: () => WelcomeScreen()),
      GetPage(
          name: _routeName(RouteName.login), page: () => const LoginScreen()),
      GetPage(name: _routeName(RouteName.home), page: () => const HomeScreen()),
      GetPage(
          name: _routeName(RouteName.forgotPassword),
          page: () => const ForgotPasswordScreen()),
      GetPage(
          name: _routeName(RouteName.setNewPassword),
          page: () => const SetNewPasswordScreen()),
      GetPage(
          name: _routeName(RouteName.register), page: () => RegisterScreen()),
      GetPage(
          name: _routeName(RouteName.createAccount),
          page: () => CreateAccountRegisterScreen()),
      GetPage(name: _routeName(RouteName.redFlag), page: () => RedFlagScreen()),
      GetPage(
          name: _routeName(RouteName.userBank), page: () => UserBanksDetails()),
      GetPage(
          name: _routeName(RouteName.userDetails), page: () => UserDetails()),
      GetPage(
          name: _routeName(RouteName.userBusiness),
          page: () => UserBusinessDetails()),
      GetPage(
          name: _routeName(RouteName.userSecurity), page: () => UserSecurity()),
      GetPage(
          name: _routeName(RouteName.portfolio), page: () => PortfolioScreen()),
      GetPage(name: _routeName(RouteName.receipt), page: () => ReceiptScreen()),
      GetPage(
          name: _routeName(RouteName.financial), page: () => FinancialScreen()),
      GetPage(
          name: _routeName(RouteName.calculator),
          page: () => CalculatorScreen()),
      GetPage(name: _routeName(RouteName.faq), page: () => FaqScreen()),
    ];
  }
}
