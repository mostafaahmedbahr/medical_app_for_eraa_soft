import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';

import '../bloc/cubit.dart';

class ProfileScreen extends StatelessWidget {
  var emailCon = TextEditingController();
  var nameCon = TextEditingController();
  var phoneCon = TextEditingController();
  var passCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        // if(state is ShopAppSuccessUserDataState)
        // {
        //   emailCon.text = state.loginModel.data!.name!;
        // }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        // nameCon.text = cubit.userModel!.data!.name!;
        // emailCon.text = cubit.userModel!.data!.email!;
        // phoneCon.text = cubit.userModel!.data!.phone!;
        return ConditionalBuilder(
          // condition: cubit.userModel !=null,
          condition: true,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  InkWell(
                    onTap: () {
                      cubit.openImagePicker(context);
                    },
                    child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          // backgroundImage:
                          // FileImage(controller.selectImage!)
                        backgroundImage: AssetImage("assets/images/fun-3d-cartoon-illustration-indian-doctor.jpg"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                          ),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        width: 85,
                        height: 24,
                        child: const Icon(
                          Icons.camera_alt,
                          color: AppColors.mainColor,
                          size: 25,
                        ),
                      )
                    ],
                ),
                  ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: nameCon,
                      keyboardType: TextInputType.name,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return "name is must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        border:OutlineInputBorder(
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
                          color: AppColors.mainColorBlack,
                        ),
                        prefixIcon: Icon(Icons.person,
                        color: AppColors.mainColorBlack,),
                      ),
                    ),
                   const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCon,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return "email is must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        border:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        focusedBorder:   OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )
                        ),
                        hintText: "email Address",
                        hintStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        ),
                        prefixIcon: Icon(Icons.email,color: AppColors.mainColorBlack,),
                      ),
                    ),
                    const  SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: phoneCon,
                      keyboardType: TextInputType.phone,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "phone is must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        border:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        focusedBorder:   OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )
                        ),
                        hintText: "Phone",
                        hintStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        ),
                        prefixIcon: Icon(Icons.phone, color: AppColors.mainColorBlack,),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: passCon,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "password is must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        border:OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )
                        ),
                        focusedBorder:   OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )
                        ),
                        hintText: "password",
                        hintStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        ),
                        prefixIcon: Icon(Icons.password,  color: AppColors.mainColorBlack,),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.mainColor,
                        ),
                        onPressed: (){
                          // if(formKey.currentState!.validate())
                          // {
                          //   cubit.upDateUserProfile(
                          //     name: nameCon.text
                          //     , phone: phoneCon.text,
                          //     email: emailCon.text,
                          //     password: passCon.text,
                          //   );
                          // }
                        },
                        child:const CustomText(text:"Update",
                            fontSize: 30,
                          ),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback:(context)=> const Center(
            child: CircularProgressIndicator(),
          ),

        );
      },

    );
  }
}