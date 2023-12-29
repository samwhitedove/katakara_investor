import 'dart:developer';

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
import 'package:katakara_investor/view/home/home.sub/homepage/home.youtube.dart';
import 'package:katakara_investor/view/product/product.full.image.dart';
import 'package:katakara_investor/view/product/product.portfolio.add.dart';
import 'package:katakara_investor/view/product/product.details.dart';
import '../view/admin/search/admin.search.view.dart';
import '../view/home/home.sub/profile/profile.information.card/home.card.info.view.dart';
import '../view/view.dart';
import 'strings.dart';

class AppRoutes {
  // static name(RouteName name) => _routeName(name);

  static List<GetPage> get routes => _appRoutes();

  static List<GetPage> _appRoutes() {
    return [
      GetPage(
        name: '/${RouteName.unknown.name}',
        page: () => const UnknownRoutePage(),
      ),
      GetPage(
        name: '/${RouteName.welcome.name}',
        page: () => WelcomeScreen(),
      ),
      GetPage(
        name: '/${RouteName.login.name}',
        page: () => const LoginScreen(),
      ),
      GetPage(name: '/${RouteName.home.name}', page: () => const HomeScreen()),
      GetPage(
          name: '/${RouteName.forgotPassword.name}',
          page: () => const ForgotPasswordScreen()),
      GetPage(
          name: '/${RouteName.setNewPassword.name}',
          page: () => const SetNewPasswordScreen()),
      GetPage(
          name: '/${RouteName.register.name}',
          page: () => const RegisterScreen(),
          bindings: [
            StepOneBinding(),
            StepTwoBinding(),
            RegisterScreenBinding()
          ]),
      GetPage(
          name: '/${RouteName.createAccount.name}',
          page: () => const CreateAccountRegisterScreen(),
          binding: StepFourBinding()),
      GetPage(
          name: '/${RouteName.redFlag.name}',
          page: () => const RedFlagScreen()),
      GetPage(
          name: '/${RouteName.userBank.name}',
          page: () => const UserBanksDetails()),
      GetPage(
          name: '/${RouteName.userDetails.name}',
          page: () => const UserDetails()),
      GetPage(
          name: '/${RouteName.userBusiness.name}',
          page: () => const UserBusinessDetails()),
      GetPage(
          name: '/${RouteName.userSecurity.name}',
          page: () => const UserSecurity()),
      GetPage(
          name: '/${RouteName.portfolio.name}',
          page: () => const PortfolioScreen()),
      GetPage(
          name: '/${RouteName.receipt.name}',
          page: () => const ReceiptScreen()),
      GetPage(
          name: '/${RouteName.financial.name}', page: () => FinancialScreen()),
      GetPage(
          name: '/${RouteName.calculator.name}',
          page: () => const CalculatorScreen()),
      GetPage(name: '/${RouteName.faq.name}', page: () => const FaqScreen()),
      GetPage(
          name: '/${RouteName.productDetails.name}',
          page: () => const ProductDetails()),
      GetPage(
          name: '/${RouteName.fullImageView.name}',
          page: () => FullImageView()),
      GetPage(
          name: '/${RouteName.addPortfolio.name}',
          page: () => const AddPortfolioProduct()),
      GetPage(
          name: '/${RouteName.createReceipt.name}',
          page: () => const CreateReceiptView()),
      GetPage(
          name: '/${RouteName.receiptReview.name}',
          page: () => HomeReceiptReview()),
      GetPage(
          name: '/${RouteName.chatScreen.name}',
          page: () => const ChatScreen()),
      GetPage(
          name: '/${RouteName.admin.name}', page: () => const AdminDashBoard()),
      GetPage(
        name: '/${RouteName.user.name}',
        page: () => const UserListView(),
      ),
      GetPage(
          name: '/${RouteName.activeProduct.name}',
          page: () => const ActiveProduct()),
      GetPage(
          name: '/${RouteName.bookedProduct.name}',
          page: () => const BookedProduct()),
      GetPage(
        name: '/${RouteName.broadcast.name}',
        page: () => const Broadcast(),
      ),
      GetPage(
          name: '/${RouteName.addProduct.name}',
          page: () => const AddProduct()),
      GetPage(
          name: '/${RouteName.viewRedFlag.name}',
          page: () => const ViewRedFlag()),
      GetPage(
          name: '/${RouteName.usersReceipts.name}',
          page: () => const UserReceipts()),
      GetPage(
          name: '/${RouteName.addReceipts.name}',
          page: () => const AddReceipt()),
      GetPage(
        name: '/${RouteName.addFaq.name}',
        page: () => const AddFAQScreen(),
      ),
      GetPage(
        name: '/${RouteName.notifications.name}',
        page: () => NotificationScreen(),
      ),
      GetPage(
        name: '/${RouteName.youtube.name}',
        page: () => YoutubePlay(),
      ),
      GetPage(
        name: '/${RouteName.search.name}',
        page: () => const SearchPage(),
      ),
      GetPage(
        name: '/${RouteName.viewInformationCard.name}',
        page: () => const ViewInformationCard(),
      ),
    ];
  }
}
