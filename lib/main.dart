import 'dart:io';

import 'package:bank_sha/bloc/auth/auth_bloc.dart';
import 'package:bank_sha/bloc/user/user_bloc.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/view/pages/data_provider/data_provider_page.dart';
import 'package:bank_sha/view/pages/data_provider/data_success_page.dart';
import 'package:bank_sha/view/pages/home_page.dart';
import 'package:bank_sha/view/pages/onboarding_page.dart';
import 'package:bank_sha/view/pages/pin_page.dart';
import 'package:bank_sha/view/pages/profile/profile_edit_page.dart';
import 'package:bank_sha/view/pages/profile/profile_edit_pin_page.dart';
import 'package:bank_sha/view/pages/profile/profile_edit_success_page.dart';
import 'package:bank_sha/view/pages/profile/profile_page.dart';
import 'package:bank_sha/view/pages/sign_in_page.dart';
import 'package:bank_sha/view/pages/sign_up/sign_up_success_page.dart';
import 'package:bank_sha/view/pages/splash_page.dart';
import 'package:bank_sha/view/pages/top_up/top_up_page.dart';
import 'package:bank_sha/view/pages/top_up/top_up_success_page.dart';
import 'package:bank_sha/view/pages/transfer/transfer_page.dart';
import 'package:bank_sha/view/pages/transfer/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view/pages/sign_up/sign_up_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        theme: themeData(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/onboarding': (context) => const OnboardingPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up': (context) => const SignUpPage(),
          '/sign-up-success': (context) => const SignUpSuccessPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/profile-edit': (context) => const ProfileEditPage(),
          '/pin': (context) => const PinPage(),
          '/profile-edit-pin': (context) => const ProfileEditPinPage(),
          '/profile-edit-success': (context) => const ProfileEditSuccessPage(),
          '/topup': (context) => const TopUpPage(),
          '/topup-success': (context) => const TopUpSuccessPage(),
          '/transfer': (context) => const TransferPage(),
          '/transfer-success': (context) => const TransferSuccessPage(),
          '/data-provider': (context) => const DataProviderPage(),
          '/data-success': (context) => const DataSuccessPage(),
        },
      ),
    );
  }

  ThemeData themeData() {
    return ThemeData(
      scaffoldBackgroundColor: lightBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: lightBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: blackColor,
        ),
        titleTextStyle: blackTextStyle.copyWith(
          fontSize: 20,
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
