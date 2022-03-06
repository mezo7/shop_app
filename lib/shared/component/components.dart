import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/color.dart';

Widget myDivaider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 2.0,
        color: Colors.grey[300],
      ),
    );

Widget defualtTextFormField({
  required controller,
  required TextInputType type,
  required FormFieldValidator validate,
  required String label,
  required IconData prefixIcon,
  IconButton? suffixIcon,
  bool isPassword = false,
  Function? suffixPressed,
  Function()? onTap,
  ValueChanged<String>? onChange,
  ValueChanged<String>? onSubmit,
  bool isClicked = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClicked,
      onFieldSubmitted: onSubmit,
    );

Widget defualtButton({
  double width = double.infinity,
  Color background = defualtColor,
  Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: background,
      ),
      child: MaterialButton(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        onPressed: function,
      ),
    );

Widget defualtTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
        onPressed: function(),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: defualtColor,
          ),
        ));

void navigateTo(context, wedgit) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => wedgit,
    ));

void navigateAndFinish(context, wedgit) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => wedgit,
      ),
      (Route<dynamic> route) => false,
    );

void showLongToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

void showShortToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { SUCCESS, ERROR, WARNING }

Color ToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = defualtColor;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
