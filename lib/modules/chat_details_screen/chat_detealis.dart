import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../models/chat_models.dart';
import '../../models/chat_user_model.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../chat_otheruser_profile/chat_otherusers_profile.dart';

  class chat_details_screen extends StatelessWidget
  {
  chat_user_model usermodel;
  chat_details_screen({required this.usermodel });
  var messagecontroller=TextEditingController();
  var datacontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        chatappcubit.get(context).getmessage(reciver: usermodel.uid);
        return BlocConsumer<chatappcubit, chatappstates>(
          listener: (context, state) {},
          builder: (context, state) {
            return
              ConditionalBuilder(
                condition:true, //chatappcubit.get(context).message.length>0,
                builder: (context)=>Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,

                          backgroundImage: NetworkImage(usermodel.image),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          usermodel.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(IconBroken.Call),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(IconBroken.Video),
                      ),
                      IconButton(
                        onPressed: () {
                          navto(context, chat_otherusers_profile(usermodel: usermodel,));
                        },
                        icon: Icon(IconBroken.Info_Circle),
                      ),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(

                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message = chatappcubit
                                  .get(context)
                                  .message[index];
                              if (chatappcubit.get(context).usermodel!.uid != message.reciver)
                              {
                                return buildmymessage(message,context);
                              }
                              else
                              {
                                return buildmessage(message,context);
                              }
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  height: 5,
                                ),
                            itemCount: chatappcubit
                                .get(context)
                                .message
                                .length,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if(chatappcubit.get(context).chatimage!=null)
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image:FileImage(chatappcubit.get(context).chatimage),
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              ),
                              IconButton(
                                onPressed: (){
                                  chatappcubit.get(context).removeimage();
                                },
                                icon: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                chatappcubit.get(context).getcahtimage();
                              },
                              icon: Icon(IconBroken.Image),
                            ),
                            IconButton(
                              onPressed: () {
                                chatappcubit.get(context).getcahtimagecam();
                              },
                              icon: Icon(IconBroken.Camera),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(IconBroken.Voice),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[100]!,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: messagecontroller,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type your message here....',

                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        if(chatappcubit.get(context).chatimage==null) {
                                          chatappcubit.get(context).sendmessage(
                                            text: messagecontroller.text,
                                            reciver: usermodel.uid,
                                            datatime: DateTime.now().toString(),
                                          );
                                        }else {
                                          chatappcubit.get(context)
                                              .sendimagemessage(
                                              dataTime: DateTime.now().toString(),
                                              text: messagecontroller.text,
                                              receiver: usermodel.uid,
                                          );
                                        }
                                      },
                                      minWidth: 1,
                                      child: Icon(
                                          IconBroken.Send, color: defaultcolor),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                fallback:(context)=> Center(child: CircularProgressIndicator()),
              );
          },

        );
      }
    );
  }
  }
  Widget buildmessage(chat_details_model model,context)
  {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Row(
        children: [
          if(model.chatimage!= '')
            InkWell(
              onTap: (){
                //navto(context, chat_image_detalis());
              },
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage('${model.chatimage}'),
                      fit: BoxFit.cover,
                    )
                ),

              ),
            ),
          if(model.chatimage!= '')
            SizedBox(
              width: 5,
            )
          else
            Container(
              decoration: BoxDecoration(
                  color:Colors.grey[300], //Colors.pink[200],
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                    bottomStart: Radius.circular(10),

                  )
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Text('${model.text}'),
            ),
          Text('${model.datatime}',style: Theme.of(context).textTheme.caption,)
        ],
      ),
    );
  }
  Widget buildmymessage(chat_details_model model,context)
  {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Row(
        children: [
          if(model.chatimage!= '')
            InkWell(
              onTap: (){
                //navto(context, chat_image_detalis());
              },
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage('${model.chatimage}'),
                      fit: BoxFit.cover,
                    )
                ),

              ),
            ),
          if(model.chatimage!= '')
            SizedBox(
              width: 5,
            )
          else
            Container(
            decoration: BoxDecoration(
                color:Colors.pink.withOpacity(0.2), //Colors.pink[200],
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),

                )
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Text('${model.text}'),
          ),

          Text('${model.datatime}',style: Theme.of(context).textTheme.caption,)
        ],
      ),
    );
  }

