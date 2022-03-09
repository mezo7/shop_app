import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/prod_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/component/constance.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

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
}

//Login Cubit Finsh
class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(HomeInitialState());

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

   HomeModel ?homeModel;

  void getHomeData() {
    emit(HomeLoadingDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      print('e1');
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners![1].image.toString());

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
      print('e1');
      catModel = CategoriesModel.fromJson(value.data);
      emit(HomeSuccessCategoriseState());
    }).catchError((error) {
      emit(HomeErrorCategoriesState());
      print('errorState');
      print(error.toString());
    });
  }
}
