import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';


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
    );
void navigateTo(context, wedgit) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => wedgit,
    ));
void navigateAndFinish(context, wedgit) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => wedgit,
    ),(Route<dynamic>route) =>false ,

);

