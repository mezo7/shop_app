import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

// login States
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisiState extends LoginStates {}

// Register States

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}
class ChangePasswordVisibState extends RegisterStates {}


//Home States

abstract class ShopStates {}

class HomeInitialState extends ShopStates {}

class HomeChangeBottomNavState extends ShopStates {}

class HomeLoadingDataState extends ShopStates {}

class HomeSuccessDataState extends ShopStates {}

class HomeErrorDataState extends ShopStates {}

class HomeSuccessCategoriseState extends ShopStates {}

class HomeErrorCategoriesState extends ShopStates {}

class ChangeFavErrorState extends ShopStates {}

class ChangeFavSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ChangeFavSuccessState(this.model);
}
class ChangeFavIconSuccessState extends ShopStates {}

class GetFavoritesLoadingState extends ShopStates {}

class GetFavoritesSuccessState extends ShopStates {}

class GetFavoritesErrorState extends ShopStates {}

class GetProfileInfoLoadingState extends ShopStates {}

class GetProfileInfoSuccessState extends ShopStates {
  final ProfileModel profileModel;

  GetProfileInfoSuccessState(this.profileModel);
}

class GetProfileInfoErrorState extends ShopStates {}

class UpdateLoadingState extends ShopStates {}

class UpdateSuccessState extends ShopStates {
  final ProfileModel profileModel;

  UpdateSuccessState(this.profileModel);

}

class UpdateErrorState extends ShopStates {}

// Search States
abstract class SearchStates{}
class SearchInitialState extends SearchStates {}
class SearchLoadingState extends SearchStates {}
class SearchSuccessState extends SearchStates {}
class SearchErrorState extends SearchStates {}

