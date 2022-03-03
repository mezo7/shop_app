import 'package:flutter/material.dart';

class CategoriseScreen extends StatelessWidget {
  const CategoriseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Categorise Screen',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
