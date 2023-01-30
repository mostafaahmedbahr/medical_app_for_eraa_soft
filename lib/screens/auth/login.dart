
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/screens/auth/register.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_button.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_sized_box.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../core/toast/toast.dart';
import '../../core/toast/toast_states.dart';
import '../../core/utils/nav.dart';
import '../../dio/end_points.dart';
import '../../dio/sh/sh.dart';
import '../layout_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    // final mediaQuery = MediaQuery.of(context).size;
    return   BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)
          {
              TOKEN = state.loginModel.token!;
              print(state.loginModel.token);
              SharedPreferencesHelper.saveData(
                key: "token",
                value: state.loginModel.token,
              );
              ToastConfig.showToast(
                msg: "${state.loginModel.message}",
                toastStates: ToastStates.Success,
              );
              AppNav.customNavigator(
                context: context,
                screen: const LayoutScreen(),
                finish: true,
              );

            }
          if(state is LoginErrorState){
            ToastConfig.showToast(
                msg: "Check Your Email and Password",
                toastStates: ToastStates.Error,
            );
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context,snapshot){
                return Scaffold(
                  body:snapshot.data == ConnectivityResult.none ?
                  Center(
                    child: CustomText(text: "No Internet",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black87,),
                  ):
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/doctor-with-his-arms-crossed-white-background.jpg",
                                width: 300,
                                height: 300,
                              ),
                              const CustomSizedBox(
                                height: 30,
                              ),
                              const CustomText(text:"Medical App",
                                fontSize: 50,
                                textColor: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                              const CustomText(text:"Welcome To Our Application",
                                fontSize: 20,
                                textColor: AppColors.grey,
                              ),
                              const CustomSizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                controller: cubit.emailCon,
                                validator: (value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return "الايميل المستخدم غير صيحيح";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border:OutlineInputBorder(),
                                  enabledBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorBlack,
                                      )
                                  ),
                                  focusedBorder:   OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColor,
                                      )
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorBlack,
                                  ),
                                  prefixIcon: Icon(Icons.email,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const CustomSizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                onFieldSubmitted: (value)
                                {
                                  if(formKey.currentState!.validate())
                                  {
                                    cubit.userLogin(
                                        email: cubit.emailCon.text,
                                        password: cubit.passCon.text);
                                  }
                                  cubit.getAllPatient();
                                },
                                obscureText: cubit.isVisible,
                                controller: cubit.passCon,
                                validator: (value){
                                  if(value!.isEmpty)
                                  {
                                    return "the email not valid ...";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border:const OutlineInputBorder(),
                                  enabledBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorBlack,
                                      )
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColor,
                                      )
                                  ),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  prefixIcon:const Icon(Icons.lock,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    icon: cubit.isVisible ?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                                    onPressed: (){
                                      cubit.changeSuffixIcon();
                                    },
                                  ),
                                ),
                              ),
                              const CustomSizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder: (context){
                                  return CustomButton(
                                    height: 60,
                                    width: double.infinity,
                                    btnColor: AppColors.mainColor,
                                    btnText: const CustomText(
                                      text: "LoGin",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      textColor: AppColors.mainColorWhite,
                                    ),
                                    onPressed: ()async{
                                      if(formKey.currentState!.validate())
                                      {
                                        cubit.userLogin(
                                          email: cubit.emailCon.text,
                                          password: cubit.passCon.text,
                                        );
                                      }
                                      // cubit.getAllPatient();
                                    },
                                  );
                                },
                                fallback: (context)=>const Center(
                                  child: CircularProgressIndicator(color: AppColors.mainColor,),
                                ),
                              ),
                              const CustomSizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(text: "Do\'t have an account ?",
                                    textColor: AppColors.mainColorBlack,
                                  ),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.push(
                                          context, PageTransition(
                                          duration: const Duration(milliseconds: 400),
                                          reverseDuration: const Duration(milliseconds: 400),
                                          type: PageTransitionType.leftToRight,
                                          child:   SignUpScreen(),
                                          inheritTheme: true,
                                          ctx: context));
                                    },
                                    child:const CustomText(text: "Sign Up",
                                      textColor: AppColors.mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                              const CustomSizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/facebook1.png",height: 50,),
                                  const CustomSizedBox(
                                    width: 20,
                                  ),
                                  Image.asset("assets/images/google.png",height: 50,),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
          );
        },
    );
  }
}