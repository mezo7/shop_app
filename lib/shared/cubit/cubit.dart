
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        },
    ).then((value) {
      print(value.data);
      emit(ShopLoginSuccessState());
    }).catchError((e){
      emit(ShopLoginErrorState(e.toString()));
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