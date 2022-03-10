import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';

import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/color.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          builder: (context)=>ListView.separated(
          itemBuilder: (context , index)=> buildFavoritesItem(ShopCubit.get(context).favoritesDataModel!.data!.data![index],context),
            separatorBuilder: (context,index)=> myDivaider(),
            itemCount: ShopCubit.get(context).favoritesDataModel!.data!.data!.length,
            physics: BouncingScrollPhysics(),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget buildFavoritesItem(FavoritesData model,context)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.product!.image}'),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.contain,
              ),
              if(1!=0)
                Container(
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${model.product!.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.price} \$',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defualtColor,
                      ),
                    ),
                     SizedBox(
                      width: 10.0,
                    ),
                    if(model.product!.discount!=0)
                      Text(
                        '${model.product!.oldPrice} \$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                     Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.product!.id!,context);

                      },
                      icon:  CircleAvatar(
                        backgroundColor:Colors.grey[200],
                        radius: 50,
                        child: Icon(
                          ShopCubit.get(context).favo[model.product!.id]! ? Icons.favorite:Icons.favorite_border,                          color: Colors.red,
                        ),
                      ),

                    ),


                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
