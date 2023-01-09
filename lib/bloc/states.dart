
import '../models/login_model.dart';
import '../models/register_model.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangeBottomNavBar extends AppStates{}

class AppLoadingGetHomeDataState extends AppStates{}

class AppSuccessGetHomeDataState extends AppStates{}

class AppErrorGetHomeDataState extends AppStates{}

class SetImageProfileFromCamera extends AppStates{}

class SetImageProfileFromGallery extends AppStates{}

class ChangeValueState extends AppStates{}

class ChangeSuffixIconState extends AppStates{}

class RegisterLoadingState extends AppStates{}
class RegisterSuccessState extends AppStates{
  RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}
class RegisterErrorState extends AppStates{
  RegisterModel registerModel;
  RegisterErrorState(this.registerModel);
}

class ChangeTypeOfUser extends AppStates{}

class LogoutLoadingState extends AppStates{}
class LogoutErrorState extends AppStates{}
class LogoutSuccessState extends AppStates{}

class LoginLoadingState extends AppStates{}

class LoginErrorState extends AppStates{
  // LoginModel? loginModel;
  // LoginErrorState(this.loginModel);
}

class LoginSuccessState extends AppStates{
  LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class GetAllPatientLoadingState extends AppStates{}
class GetAllPatientErrorState extends AppStates{}
class GetAllPatientSuccessState extends AppStates{}