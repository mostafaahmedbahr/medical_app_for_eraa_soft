
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/screens/auth/register.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_button.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc/cubit.dart';
import '../../bloc/states.dart';


class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailCon = TextEditingController();
    var passCon = TextEditingController();
    final mediaQuery = MediaQuery.of(context).size;
    return   BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/fun-3d-cartoon-illustration-indian-doctor (1).jpg",
                        width: 300,
                        height: 300,
                        ),
                        const SizedBox(
                          height: 30.0,
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
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          controller: emailCon,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "الايميل المستخدم غير صيحيح";
                            }
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
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          onFieldSubmitted: (value)
                          {
                            // if(formKey.currentState!.validate())
                            // {
                            //   cubit.userLogin(
                            //       email: emailCon.text,
                            //       password: passCon.text);
                            // }

                          },
                          obscureText: cubit.isVisible,
                          controller: passCon,
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
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomButton(
                            height: 60,
                            width: double.infinity,
                            btnColor: AppColors.mainColor,
                            btnText: const CustomText(
                              text: "LoGin",
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.mainColorWhite,
                            ),
                            onPressed: (){},
                        ),
                        const SizedBox(
                          height: 15.0,
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
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/facebook1.png",height: 50,),
                            const SizedBox(width: 20,),
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
  }
}