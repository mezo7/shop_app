import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, Object? state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Metro',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.BottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categorise'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                  ),
                  label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings'),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
          ),
        );
      },
    );
  }
}
