import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/dio/end_points.dart';
import 'package:medical_app_for_eraa_soft/screens/auth/login.dart';
import 'package:medical_app_for_eraa_soft/screens/auth/register.dart';
import 'package:medical_app_for_eraa_soft/screens/layout_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'bloc/cubit.dart';
import 'dio/dio_helper.dart';
import 'dio/sh/sh.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  DioHelper.init();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
    MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TOKEN = SharedPreferencesHelper.getData(key:"token")??"";
    return BlocProvider(
        create: (context)=>AppCubit(),
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TOKEN == "" ?  LoginScreen() :const LayoutScreen(),
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
    ),);

  }
}
