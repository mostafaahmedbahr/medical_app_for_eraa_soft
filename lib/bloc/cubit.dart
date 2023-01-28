import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:medical_app_for_eraa_soft/dio/end_points.dart';
import 'package:medical_app_for_eraa_soft/models/get_all_patient_model.dart';
import 'package:medical_app_for_eraa_soft/models/logout_model.dart';
import 'package:medical_app_for_eraa_soft/screens/auth/login.dart';
import '../core/colors.dart';
import '../core/utils/nav.dart';
import '../dio/dio_helper.dart';
import '../dio/sh/sh.dart';
import '../models/add_patient_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
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

  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var nameCon = TextEditingController();
  var titleCon = TextEditingController();
  var addressCon = TextEditingController();
  // var typeCon = TextEditingController();
  LoginModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String title,
    required String address,
    required String type,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url:  "auth/register",
      data: {
        "name" : name,
        "email":email,
        "password":password,
        "title":title,
        "address":address,
        "type" : type,
      },
    ).then((value)
    {
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error)
    {
      print("error in register ${error.toString()}");
      emit(RegisterErrorState(loginModel!));
    });
  }

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: "auth/login",
      data: {
        "email":email,
        "password":password,
      },
    ).then((value)
    {
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print("error in login ${error.toString()}");
      emit(LoginErrorState());
    });
  }

  var typeIndex ;
  changeTypeOfUser(type)
  {
    typeIndex = type;
    emit(ChangeTypeOfUser());
  }

  LogoutModel? logoutModel;
  void signOut(BuildContext context)
  {
    SharedPreferencesHelper.removeData(
        key: "token").then((value)
    {
      if(value)
      {
        AppNav.customNavigator(
          context: context,
          screen: LoginScreen(),
          finish: true,
        );
      }
    });
  }



  GetAllPatientModel? getAllPatientModel;
  getAllPatient()
  {
    emit(GetAllPatientLoadingState());
    DioHelper.getData(
      url: "doctorpatients",
      token: TOKEN,
    ).then((value)
    {
      print("nnnnnnnnnn");
      print(value.data);
      getAllPatientModel= GetAllPatientModel.fromJson(value.data);
      emit(GetAllPatientSuccessState());
    }).catchError((error)
    {
      print("error in get all getAllPatient  ${error.toString()}");
      emit(GetAllPatientErrorState());
    });
  }

  AddPatientModel? addPatientModel;
  addPatient({
    required String name,
    required String dateOfBirth,
    required String diagnosis,
    required String address,
    required String visitTime,

  })
  {
    emit(AddPatientLoadingState());
    DioHelper.postData(
      url: "doctorpatients",
      data: {
        "name" : name,
        "date_of_birth" :dateOfBirth ,
        "diagnosis" : diagnosis,
        "address" :address ,
        "visit_time" : visitTime,
      },
      token: TOKEN,
    ).then((value)
    {
      print(value.data);
      print("add success");
      addPatientModel= AddPatientModel.fromJson(value.data);
      emit(AddPatientSuccessState());
    }).catchError((error)
    {
      print("error in addPatient ${error.toString()}");
      emit(AddPatientErrorState());
    });
  }



  updatePatient({
    required String name,
    required String dateOfBirth,
    required String diagnosis,
    required String address,
    required String visitTime,
    required String patientId,
  })
  {
    emit(UpdatePatientLoadingState());
    DioHelper.postData(
      url: "doctorpatients/$patientId?_method=put",
      data: {
        "name" : name,
        "date_of_birth" :dateOfBirth ,
        "diagnosis" : diagnosis,
        "address" :address ,
        "visit_time" : visitTime,
      },
      token: TOKEN,
    ).then((value)
    {
      print(value.data);
      print("Update success");
      getAllPatientModel= GetAllPatientModel.fromJson(value.data);
      emit(UpdatePatientSuccessState());
    }).catchError((error)
    {
      print("error in Update Patient ${error.toString()}");
      emit(UpdatePatientErrorState());
    });
  }


  updateProfile({
    required String name,
    required String password,
    required String address,
    required String title,
    required String id,
  })
  {
    emit(UpdateProfileLoadingState());
    DioHelper.postData(
      url: "updatadata/$id?_method=put",
      data: {
        "name" : name,
        "password" :password ,
        "type" : "admin",
        "title" : title,
        "address" :address ,
      },
      token: TOKEN,
    ).then((value)
    {
      print(value.data);
      print("Update profile success");
      loginModel = LoginModel.fromJson(value.data);
      emit(UpdateProfileSuccessState());
    }).catchError((error)
    {
      print("error in Update profile ${error.toString()}");
      emit(UpdateProfileErrorState());
    });
  }







}




