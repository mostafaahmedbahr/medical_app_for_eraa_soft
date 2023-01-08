

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';

import '../core/colors.dart';
import '../screens/reports_screen.dart';
import '../screens/home_screen.dart';
import '../screens/more_screen.dart';
import '../screens/profil_screen.dart';
import '../widgets/custom_text.dart';
import 'dart:io';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context)=>BlocProvider.of(context);

  int bottomNavBarIndex = 0;
  changeBottomNavBarIndex(index){
    bottomNavBarIndex = index;
    emit(AppChangeBottomNavBar());
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();


  List screens =  [
     HomeScreen(),
    ReportsScreen(),
    ProfileScreen(),
    MoreScreen(),
  ];

  List appBarTitles =  [
     "Home Screen",
    "Reports Screen",
    "Profile Screen",
    "More Screen",
  ];

  // camera
  final picker = ImagePicker();
  File? selectImage;
  Future<void> openCamera(context) async {
    final pickedFile = await picker.pickImage(
        imageQuality: 50,
        maxHeight: 300,
        maxWidth: 400,
        source: ImageSource.camera);
    if (pickedFile != null) {
      selectImage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(SetImageProfileFromCamera());
  }
  Future<void> openGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(
        imageQuality: 50,
        maxHeight: 300,
        maxWidth: 400,
        source: ImageSource.gallery);

    if (pickedFile != null) {
      selectImage = File(pickedFile.path);

    } else {
      print('No image selected.');
    }
    emit(SetImageProfileFromGallery());
  }
  void openImagePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext openImagePicker) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoActionSheet(
            cancelButton: CupertinoButton(
                child:  const CustomText(
                  text: 'Cancel',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  textColor: AppColors.mainColorBlack,
                ),
                onPressed: () => Navigator.of(context).pop()),
            actions: <Widget>[

              TextButton(
                  onPressed: () {},
                  child:  const Text('Choose file',
                      style:TextStyle(
                        color: AppColors.mainColor,
                      ),textAlign: TextAlign.center)),
              pickItem(
                  title:'Camera',
                  icon:'assets/images/camera.png',
                  onClick: () {
                    openCamera(context);
                    Navigator.pop(context);
                  }),

              pickItem(
                  title: 'Gallery',
                  icon: 'assets/images/gallery.png',
                  onClick: () {
                    openGallery(context);
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
  }
  Widget pickItem(
      {required String title,
        required String icon,
        required VoidCallback onClick}) =>
      TextButton(
          onPressed: onClick,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,style:const TextStyle(
                    color: AppColors.mainColor,
                  ),),
                  Image.asset(icon, height: 40),
                ]),
          )
      );

// end

  bool value= false;
  changeValue(val){
    value = val;
    emit(ChangeValueState());
  }

  bool isVisible = true;
  void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeSuffixIconState());
  }


}




