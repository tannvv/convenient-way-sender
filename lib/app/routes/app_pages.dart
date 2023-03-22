import 'package:get/get.dart';

import '../modules/create_package_page/bindings/create_package_page_binding.dart';
import '../modules/create_package_page/views/create_package_page_view.dart';
import '../modules/feedback_for_deliver/bindings/feedback_for_deliver_binding.dart';
import '../modules/feedback_for_deliver/views/feedback_for_deliver_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification_page/bindings/notification_page_binding.dart';
import '../modules/notification_page/views/notification_page_view.dart';
import '../modules/package_detail/bindings/package_detail_binding.dart';
import '../modules/package_detail/views/package_detail_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/payment_status/bindings/payment_status_binding.dart';
import '../modules/payment_status/views/payment_status_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/report-package/bindings/report_package_binding.dart';
import '../modules/report-package/views/report_package_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/tracking_package/bindings/tracking_package_binding.dart';
import '../modules/tracking_package/views/tracking_package_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/verify-otp/bindings/verify_otp_binding.dart';
import '../modules/verify-otp/views/verify_otp_view.dart';
import '../modules/vnpay/bindings/vnpay_binding.dart';
import '../modules/vnpay/views/vnpay_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.VNPAY,
      page: () => const VnpayView(),
      binding: VnpayBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_STATUS,
      page: () => const PaymentStatusView(),
      binding: PaymentStatusBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK_FOR_DELIVER,
      page: () => const FeedbackForDeliverView(),
      binding: FeedbackForDeliverBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_PAGE,
      page: () => const NotificationPageView(),
      binding: NotificationPageBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PACKAGE_PAGE,
      page: () => const CreatePackagePageView(),
      binding: CreatePackagePageBinding(),
    ),
    GetPage(
      name: _Paths.TRACKING_PACKAGE,
      page: () => const TrackingPackageView(),
      binding: TrackingPackageBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGE_DETAIL,
      page: () => const PackageDetailView(),
      binding: PackageDetailBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_PACKAGE,
      page: () => const ReportPackageView(),
      binding: ReportPackageBinding(),
    ),
  ];
}
