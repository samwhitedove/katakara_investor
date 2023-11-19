import 'package:get/get.dart';
import 'package:katakara_investor/view/admin/broadcast/admin.broadcast.view.dart';
import 'package:katakara_investor/view/admin/dashboard/admin.dashboard.view.dart';
import 'package:katakara_investor/view/admin/faq/admin.faq.view.dart';
import 'package:katakara_investor/view/admin/products/active/admin.product.active.view.dart';
import 'package:katakara_investor/view/admin/products/add/admin.product.add.view.dart';
import 'package:katakara_investor/view/admin/products/booked/admin.product.booked.view.dart';
import 'package:katakara_investor/view/admin/receipts/admin.receipt.add.view.dart';
import 'package:katakara_investor/view/admin/receipts/admin.receipt.receipts.view.dart';
import 'package:katakara_investor/view/admin/red_flag/admin.redflag.view.dart';
import 'package:katakara_investor/view/admin/users/admin.user.view.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepFour.controller.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepOne.controller.dart';
import 'package:katakara_investor/view/auth/register/register_controller/stepTwo.controller.dart';
import 'package:katakara_investor/view/home/home.notification/home.notification.view.dart';
import 'package:katakara_investor/view/home/home.receipt/home.receipt.reveiw.dart';
import 'package:katakara_investor/view/home/home.receipt/home.receipt.create.dart';
import 'package:katakara_investor/view/home/home.sub/chat/chat.screen.dart';
import 'package:katakara_investor/view/product/product.full.image.dart';
import 'package:katakara_investor/view/product/product.portfolio.add.dart';
import 'package:katakara_investor/view/product/product.details.dart';
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
      case RouteName.productDetails:
        return '/productDetails';
      case RouteName.fullImageView:
        return '/fullImageView';
      case RouteName.addPortfolio:
        return '/addPortfolio';
      case RouteName.createReceipt:
        return '/createReceipt';
      case RouteName.receiptReview:
        return '/receiptReview';
      case RouteName.chatScreen:
        return '/chatScreen';
      case RouteName.admin:
        return '/admin';
      case RouteName.user:
        return '/user';
      case RouteName.notifications:
        return '/notifications';
      default:
        return '/unknown';
    }
  }

  static List<GetPage> _appRoutes() {
    return [
      GetPage(
        name: _routeName(RouteName.unknown),
        page: () => const UnknownRoutePage(),
      ),
      GetPage(
        name: _routeName(RouteName.welcome),
        page: () => WelcomeScreen(),
      ),
      GetPage(
        name: _routeName(RouteName.login),
        page: () => const LoginScreen(),
      ),
      GetPage(name: _routeName(RouteName.home), page: () => const HomeScreen()),
      GetPage(
          name: _routeName(RouteName.forgotPassword),
          page: () => const ForgotPasswordScreen()),
      GetPage(
          name: _routeName(RouteName.setNewPassword),
          page: () => const SetNewPasswordScreen()),
      GetPage(
          name: _routeName(RouteName.register),
          page: () => const RegisterScreen(),
          bindings: [
            StepOneBinding(),
            StepTwoBinding(),
            RegisterScreenBinding()
          ]),
      GetPage(
          name: _routeName(RouteName.createAccount),
          page: () => const CreateAccountRegisterScreen(),
          binding: StepFourBinding()),
      GetPage(
          name: _routeName(RouteName.redFlag),
          page: () => const RedFlagScreen()),
      GetPage(
          name: _routeName(RouteName.userBank),
          page: () => const UserBanksDetails()),
      GetPage(
          name: _routeName(RouteName.userDetails),
          page: () => const UserDetails()),
      GetPage(
          name: _routeName(RouteName.userBusiness),
          page: () => const UserBusinessDetails()),
      GetPage(
          name: _routeName(RouteName.userSecurity),
          page: () => const UserSecurity()),
      GetPage(
          name: _routeName(RouteName.portfolio),
          page: () => const PortfolioScreen()),
      GetPage(
          name: _routeName(RouteName.receipt),
          page: () => const ReceiptScreen()),
      GetPage(
          name: _routeName(RouteName.financial), page: () => FinancialScreen()),
      GetPage(
          name: _routeName(RouteName.calculator),
          page: () => const CalculatorScreen()),
      GetPage(name: _routeName(RouteName.faq), page: () => const FaqScreen()),
      GetPage(
          name: _routeName(RouteName.productDetails),
          page: () => const ProductDetails()),
      GetPage(
          name: _routeName(RouteName.fullImageView),
          page: () => FullImageView()),
      GetPage(
          name: _routeName(RouteName.addPortfolio),
          page: () => const AddPortfolioProduct()),
      GetPage(
          name: _routeName(RouteName.createReceipt),
          page: () => const CreateReceiptView()),
      GetPage(
          name: _routeName(RouteName.receiptReview),
          page: () => HomeReceiptReview()),
      GetPage(
          name: _routeName(RouteName.chatScreen),
          page: () => const ChatScreen()),
      GetPage(
          name: _routeName(RouteName.admin),
          page: () => const AdminDashBoard()),
      GetPage(
        name: _routeName(RouteName.user),
        page: () => const UserListView(),
      ),
      GetPage(
          name: _routeName(RouteName.activeProduct),
          page: () => const ActiveProduct()),
      GetPage(
          name: _routeName(RouteName.bookedProduct),
          page: () => const BookedProduct()),
      GetPage(
        name: _routeName(RouteName.broadcast),
        page: () => const Broadcast(),
      ),
      GetPage(
          name: _routeName(RouteName.addProduct),
          page: () => const AddProduct()),
      GetPage(
          name: _routeName(RouteName.viewRedFlag),
          page: () => const ViewRedFlag()),
      GetPage(
          name: _routeName(RouteName.usersReceipts),
          page: () => const UserReceipts()),
      GetPage(
          name: _routeName(RouteName.addReceipts),
          page: () => const AddReceipt()),
      GetPage(
        name: _routeName(RouteName.addFaq),
        page: () => const AddFaq(),
      ),
      GetPage(
        name: _routeName(RouteName.notifications),
        page: () => const NotificationScreen(),
      ),
    ];
  }
}
