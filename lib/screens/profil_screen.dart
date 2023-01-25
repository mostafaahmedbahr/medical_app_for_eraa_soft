import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';
import '../bloc/cubit.dart';
class ProfileScreen extends StatelessWidget {
    ProfileScreen({Key? key}) : super(key: key);
  var passCon = TextEditingController();
    var formKey = GlobalKey<FormState>();
    String? name  , title , address;
    @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is UpdateProfileSuccessState){
          final snackBar = SnackBar(
            content: const Text('Update is done'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Form(
          key: formKey,
          child: ConditionalBuilder(
            condition: state is ! LoginSuccessState,
            builder: (context)=>Padding(
              padding: const EdgeInsets.all(20.0),
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
                      initialValue: cubit.loginModel!.data!.name,
                      keyboardType: TextInputType.name,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return "name is must not be empty";
                        }
                        return null;
                      },
                      onChanged: (val){
                        name = val;
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
                      readOnly: true,
                      initialValue: cubit.loginModel!.data!.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return "email is must not be empty";
                        }
                        return null;
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
                      controller: passCon,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      obscureText: cubit.isVisible,
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
                        hintText: "New password",
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
                    const  SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: cubit.loginModel!.data!.title,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Please Enter title";
                        }
                        return null;
                      },
                      onChanged: (val){
                        title = val;
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
                      initialValue: cubit.loginModel!.data!.address,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Please Enter address";
                        }
                        return null;
                      },
                      onChanged: (val){
                        address = val;
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
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.mainColor,
                        ),
                        onPressed: (){
                          if(formKey.currentState!.validate())
                          {
                            cubit.updateProfile(
                                name: name.toString(),
                                password: passCon.text.toString(),
                                address: address.toString(),
                                title: title.toString(),
                                id: cubit.loginModel!.data!.id.toString(),
                            );
                          }
                          print("111111111111");
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
            fallback:(context)=> const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },

    );
  }
}