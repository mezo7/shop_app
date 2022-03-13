import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/prod_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constance.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

import '../../models/change_favorites_model.dart';
import '../../models/favorites_model.dart';
import '../../models/profile_model.dart';
import '../../models/register_model.dart';

// Login Cubit Start
class ShopLoginCubit extends Cubit<LoginStates> {
  ShopLoginCubit() : super(LoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
      print(e.toString());
    });
  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;

  void changePassVisi() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_rounded;
    emit(ChangePasswordVisiState());
  }
} //Login Cubit Finsh


// Register Cubit Start

class ShopRegisterCubit extends Cubit<RegisterStates> {
  ShopRegisterCubit() : super(RegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email': email,
        'password': password,
        'phone' : phone,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      showShortToast(text: registerModel!.message.toString(), state: ToastStates.SUCCESS);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((e) {
      showShortToast(text: registerModel!.message.toString(), state: ToastStates.ERROR);
      emit(RegisterErrorState(e.toString()));
      print(e.toString());
    });
  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;

  void changePassVisi() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_rounded;
    emit(ChangePasswordVisibState());
  }
}//Register Cubit Finsh



// Main Cubit Start Here
class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(context) : super(HomeInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> BottomScreens = [
    ProductsScreen(),
    CategoriseScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int,bool> favo = {};
  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favo.addAll({
          element.id!:element.isFav!
        });
      });
      emit(HomeSuccessDataState());
    }).catchError((error) {
      emit(HomeErrorDataState());
      print('errorState');
      print(error.toString());
    });
  }

  CategoriesModel? catModel;
  void getCategorise() {
    DioHelper.getData(
      url: GET_CATEGORISE,
      token: token,
    ).then((value) {
      catModel = CategoriesModel.fromJson(value.data);
      emit(HomeSuccessCategoriseState());
    }).catchError((error) {
      emit(HomeErrorCategoriesState());
      print('errorState');
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int prodId,context){
    favo[prodId] = !favo[prodId]!;
    emit(ChangeFavIconSuccessState());

    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':prodId
        },
      token: token,
    ).then((value) {
      changeFavoritesModel= ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!){
        favo[prodId] = !favo[prodId]!;
      }else{
        getFavorites();
      }
      if(ShopCubit.get(context).favo[prodId]!){
        showShortToast(text: 'Added Successfully', state:ToastStates.SUCCESS);
      }else{
        if(!changeFavoritesModel!.status!){
          showShortToast(text: changeFavoritesModel!.message!, state:ToastStates.ERROR);
        }
      }
      emit(ChangeFavSuccessState(changeFavoritesModel!));
    }
    ).catchError((erorr){
       favo[prodId] = !favo[prodId]!;
       print(erorr.toString());
      emit(ChangeFavErrorState());

  });
  }

  FavoritesDataModel? favoritesDataModel;
  void getFavorites() {
    emit(GetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesDataModel = FavoritesDataModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((error) {
      emit(GetFavoritesErrorState());
      print('FavoErrorState');
      print(error.toString());
    });
  }

  ProfileModel? profileModel;
  void getProfileData(){
    emit(GetProfileInfoLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      profileModel=ProfileModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(GetProfileInfoSuccessState(profileModel!));
    }).catchError((error){
      emit(GetProfileInfoErrorState());
      print(error.toString());
    });

  }

  void updateProfileInfo({
    required String name,
    required String email,
    required String phone,

}){
    emit(UpdateLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFIlE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      profileModel=ProfileModel.fromJson(value.data);
      showShortToast(text: profileModel!.message.toString(), state: ToastStates.SUCCESS);
      emit(UpdateSuccessState(profileModel!));
    }).catchError((error){
      showShortToast(text: profileModel!.message.toString(), state: ToastStates.SUCCESS);
      emit(UpdateErrorState());
      print(error.toString());
    });

  }

} // Main Cubit Finsh Here

// Search Cubit Start

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text){
    DioHelper.postData(
      url: SEARCH_PRODUCT,
      data: {
        'text':text
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error);
    });
  }

}








