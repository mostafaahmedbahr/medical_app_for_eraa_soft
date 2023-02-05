
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
  LoginModel loginModel;
  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends AppStates{

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

class AddPatientLoadingState extends AppStates{}
class AddPatientErrorState extends AppStates{}
class AddPatientSuccessState extends AppStates{}

class UpdatePatientLoadingState extends AppStates{}
class UpdatePatientErrorState extends AppStates{}
class UpdatePatientSuccessState extends AppStates{}

class UpdateProfileLoadingState extends AppStates{}
class UpdateProfileErrorState extends AppStates{}
class UpdateProfileSuccessState extends AppStates{}

class SearchLoadingState extends AppStates{}
class SearchErrorState extends AppStates{}
class SearchSuccessState extends AppStates{}

class ChangeVisibleState extends AppStates{}