import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/styles/color.dart';

class SearchScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defualtTextFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return 'Enter Text To Search';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefixIcon: Icons.search,
                      onSubmit: (String text){
                          SearchCubit.get(context).search(text);
                      }
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 15.0,
                    ),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                        itemBuilder: (context , index)=> buildSearchItem(SearchCubit.get(context).searchModel!.data!.data![index],context,false),
                        separatorBuilder: (context,index)=> myDivaider(),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                        physics: BouncingScrollPhysics(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget buildSearchItem( model,context,bool isOldPrice)=>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.contain,
              ),
              if(model.discount!=0&&isOldPrice)
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
                  '${model.name}',
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
                      '${model.price} \$',
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
                    if(model.discount!=0&& isOldPrice)
                      Text(
                        '${model.oldPrice} \$',
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
                        ShopCubit.get(context).changeFavorites(model.id!,context);

                      },
                      icon:  CircleAvatar(
                        backgroundColor:Colors.grey[200],
                        radius: 50,
                        child: Icon(
                          ShopCubit.get(context).favo[model.id]! ? Icons.favorite:Icons.favorite_border,                          color: Colors.red,
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
