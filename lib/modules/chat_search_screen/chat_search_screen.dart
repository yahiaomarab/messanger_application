import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../shared/component/components.dart';

class chat_search_screen extends StatelessWidget
{
  var searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          chatappcubit.get(context).GetAllUser();
          return BlocConsumer<chatappcubit,chatappstates>(
            listener: (context,state){},
            builder: (context,state){
              return  Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      formfield(
                        controller: searchcontroller,
                        type: TextInputType.text,
                        validate: (String? value){
                          if(value!.isEmpty)
                            return 'what you want';
                          else
                            return null;
                        },
                        label: 'search',
                        onChanged: (value){
                          chatappcubit.get(context).getSearch(value);
                        },
                        prefix: Icons.search,
                      ),
                      Expanded(
                          child:ConditionalBuilder(
                            condition: chatappcubit.get(context).users.length>0,
                            builder: (context) => chatappcubit.get(context).search.isNotEmpty ? ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context , index) => buildSearchItem(chatappcubit.get(context).search[index] , context),
                                separatorBuilder: (context , index) => dividorline(),
                                itemCount: chatappcubit.get(context).search.length
                            ) :  ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context , index) => buildSearchItem(chatappcubit.get(context).users[index] , context),
                                separatorBuilder: (context , index) => dividorline(),
                                itemCount: chatappcubit.get(context).users.length
                            ),
                            fallback: (context) =>  Center(
                              child: Container(),
                            ) ,

                          )
                      ),
                    ],
                  ),
                ),
              );
            },

          );
        }
    );

  }

}