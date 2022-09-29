import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../models/chat_user_model.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../chat_details_screen/chat_detealis.dart';
import '../chat_search_screen/chat_search_screen.dart';

class chats extends StatelessWidget
{

  var  searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          chatappcubit.get(context).GetAllUser();
          return  BlocConsumer<chatappcubit,chatappstates>(
            listener: (context,state){},
            builder: (context,state){
              return  ConditionalBuilder(
                condition: chatappcubit.get(context).users.length>0,
                builder: (context)=>Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Search',
                            prefixIcon: Icon(Icons.search_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),

                            ),

                          ),
                          onTap: (){
                            navto(context, chat_search_screen());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 100,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){},
                                child: Container(
                                  width: 70,
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.center ,
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 27,
                                            child: Icon(IconBroken.Video),
                                          ),
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                                color: Colors.purple[300],
                                                borderRadius: BorderRadius.circular(7.5)
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'start call',
                                        maxLines: 2,
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder:(context,index)=> builtactivechatitem(context,chatappcubit.get(context).users[index]),
                                  separatorBuilder: (context,index)=>SizedBox(width: 5,),
                                  itemCount: chatappcubit.get(context).users.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>builtchat(context,chatappcubit.get(context).users[index]),
                            separatorBuilder: (context,index)=>SizedBox(
                              height: 20,
                            ),
                            itemCount: chatappcubit.get(context).users.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator()),
              );
            },

          );

        }
    );

  }
  Widget builtactivechatitem (context,chat_user_model model)
  {
    return InkWell(
      onTap: (){
        navto(context, chat_details_screen(usermodel: model,)
        );
      },
      child: Container(
        width: 70,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center ,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 27,

                  backgroundImage: NetworkImage('${model.image}'),
                ),
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(7.5)
                  ),
                ),
              ],
            ),
            Text(
              '${model.name}',
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
  Widget builtchat (context,chat_user_model model)
  {
    return InkWell(
      onTap: (){
        navto(context, chat_details_screen(
          usermodel: model,
        ));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,

            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(
                    'hello yahia im nader ashour ',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    '12:5',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ) ;
  }
}