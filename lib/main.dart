import 'package:akunku/compound/routes.dart';
import 'package:akunku/view/Auth/login.dart';
import 'package:akunku/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          initialRoute: '/',
          routes: {Routes.loginScreen: (context) => LoginScreenAuth()},
          debugShowCheckedModeBanner: false,
          home: Scaffold(resizeToAvoidBottomInset: false, body: SplashScreen()),
        );
      },
    );
  }
}
