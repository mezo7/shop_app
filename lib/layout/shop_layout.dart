import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_sceen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
   ShopLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Metro',
        ),
      ),
      body: TextButton(
        child: Text('Sign out'),
        onPressed: (){
          CacheHelper.removeData(key: 'token').then((value) {
            if(value){
              navigateAndFinish(context, LoginScreen());
            }
          });
        },
      ),
    );
  }
}
