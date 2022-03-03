
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/prod_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constance.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

// Login Cubit Start
class ShopLoginCubit extends Cubit<LoginStates>{

  ShopLoginCubit() : super(LoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  void userLogin({
  required String email,
  required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((e){
      emit(LoginErrorState(e.toString()));
      print(e.toString());
    });
  }
  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;
  void changePassVisi(){
    isPassword=!isPassword;
    suffix=isPassword ? Icons.remove_red_eye : Icons.visibility_off_rounded;
    emit(ChangePasswordVisiState());
  }

}
//Login Cubit Finsh
class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(HomeInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> BottomScreens=[
    ProductsScreen(),
    SearchScreen(),
    CategoriseScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottomScreen(int index)
  {
    currentIndex=index;
    emit(HomeChangeBottomNavState());
  }
  late HomeModel homeModel;
  void getHomeData(){
    emit(HomeLoadingDataState());
    DioHelper.getData(
        url: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel.toString());
      emit(HomeSuccessDataState());
    }).catchError((error){
      emit(HomeErrorDataState());
      print(error.toString());
      showShortToast(text: error.toString(), state:ToastStates.ERROR);
    });

  }

}