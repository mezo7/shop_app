import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

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
