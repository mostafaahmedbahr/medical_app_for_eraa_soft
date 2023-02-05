
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/screens/layout_screen.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_button.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';

import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../core/toast/toast.dart';
import '../../core/toast/toast_states.dart';
import '../../core/utils/nav.dart';
import '../../dio/end_points.dart';
import '../../dio/sh/sh.dart';
import '../../widgets/custom_sized_box.dart';


class SignUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();


  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is RegisterSuccessState)
        {
            // مهم
            TOKEN = state.loginModel.token!;
            debugPrint(state.loginModel.token);
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
          if(state is RegisterErrorState)
          {
            ToastConfig.showToast(
              msg: "Verify the data you entered , perhaps the email is already used",
              toastStates: ToastStates.Error,
            );

          }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return  SafeArea(
          child: StreamBuilder<ConnectivityResult>(
    stream: Connectivity().onConnectivityChanged,
    builder: (context,snapshot){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.mainColor,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: snapshot.data == ConnectivityResult.none ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/wifi.png",
                height: 100,),
              CustomSizedBox(
                height: 20,
              ),
              CustomText(text: "No Internet",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                textColor: Colors.black87,),
            ],
          ),
        ):
        SizedBox(
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/doctor-with-his-arms-crossed-white-background.jpg",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const CustomText(text:"Sign Up",
                        fontSize: 50,
                        textColor: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const CustomText(text: "Sign with us to know more ...",
                        fontSize: 20,
                        textColor: Colors.grey,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.name,
                        controller: cubit.nameCon,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
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
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(Icons.person,
                            color: Colors.black,),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: cubit.emailCon,
                        validator: (value)
                        {
                          if(value!.isEmpty || value.length < 6)
                          {
                            return "Please Enter Your Email";
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
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
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(Icons.email,
                            color: Colors.black,),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        obscureText: cubit.isVisible,
                        controller: cubit.passCon,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return "Config Your password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border:const OutlineInputBorder(),
                          enabledBorder:const  OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColorBlack,
                              )
                          ),
                          focusedBorder:  const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColor,
                              )
                          ),
                          hintText: "password",
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon:const Icon(Icons.lock,
                            color: Colors.black,),
                          suffixIcon: IconButton(
                            color: Colors.white,
                            icon: cubit.isVisible ?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                            onPressed: (){
                              cubit.changeSuffixIcon();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.text,
                        controller: cubit.titleCon,
                        validator: (value)
                        {
                          if(value!.isEmpty|| value.length<6)
                          {
                            return "The title must be at least 6 characters.";
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
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
                          hintText: "Title",
                          hintStyle:   TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(Icons.title,
                            color: Colors.black,),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.text,
                        controller: cubit.addressCon,
                        validator: (value)
                        {
                          if(value!.isEmpty || value.length<6)
                          {
                            return "The address must be at least 6 characters.";
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
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
                          hintText: "Address",
                          hintStyle:   TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(Icons.place_rounded,
                            color: Colors.black,),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      // Row(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Radio(value: "admin", groupValue: cubit.typeIndex,
                      //           onChanged: (val){
                      //             cubit.changeTypeOfUser(val);
                      //             debugPrint(cubit.typeIndex);
                      //           },
                      //         ),
                      //         const Text("admin"),
                      //
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Radio(value: "user", groupValue: cubit.typeIndex,
                      //           onChanged: (val){
                      //             cubit.changeTypeOfUser(val);
                      //             debugPrint(cubit.typeIndex);
                      //           },
                      //         ),
                      //         const Text("user"),
                      //       ],
                      //     ),
                      //
                      //   ],
                      // ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         color: AppColors.mainColor,
                      //       ),
                      //       height: 50,
                      //       width: 50,
                      //       child: IconButton(
                      //         onPressed: (){},
                      //         icon: const FaIcon(FontAwesomeIcons.facebookF),
                      //         color: Colors.white,
                      //         iconSize: 30,),
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         color: AppColors.mainColor,
                      //       ),
                      //       height: 50,
                      //       width: 50,
                      //       child: IconButton(
                      //         onPressed: (){},
                      //         icon:const FaIcon(FontAwesomeIcons.google),
                      //         color: Colors.white,
                      //         iconSize: 30,),
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         color:AppColors.mainColor,
                      //       ),
                      //       height: 50,
                      //       width: 50,
                      //       child: IconButton(
                      //         onPressed: (){},
                      //         icon: const FaIcon(FontAwesomeIcons.twitter),
                      //         color: Colors.white,
                      //         iconSize: 30,),
                      //     ),
                      //
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 30.0,
                      // ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState || state is! RegisterErrorState,
                        builder: (context)=> SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: CustomButton(
                            height: 60,
                            onPressed: () async{
                             if(formKey.currentState!.validate()){
                               cubit.userRegister(
                                 email: cubit.emailCon.text,
                                 password: cubit.passCon.text,
                                 name: cubit.nameCon.text,
                                 title: cubit.titleCon.text,
                                 address: cubit.addressCon.text,

                               );
                             }
                              // cubit.userRegister(
                              //     email: "email",
                              //     password: "123456789",
                              //     name: "name",
                              //     title: "title",
                              //     address: "address", type: "admin",
                              // );
                            },
                            btnColor: AppColors.mainColor,
                            btnText:const CustomText(
                              text: "Sign Up",
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            width: double.infinity,
                          ),
                        ),
                        fallback: (context)=>const Center(
                          child: CircularProgressIndicator(color: AppColors.mainColor,),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

          ),
        );
      },

    );
  }
}