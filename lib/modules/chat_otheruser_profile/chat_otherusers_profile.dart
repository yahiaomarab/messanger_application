import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../models/chat_user_model.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../chat_details_screen/chat_detealis.dart';

class chat_otherusers_profile extends StatelessWidget
{
  chat_user_model usermodel;
  chat_otherusers_profile({required this.usermodel });
  var Namecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context) {
          chatappcubit.get(context).GetUserData();
          return BlocConsumer<chatappcubit,chatappstates>(
            listener: (context,state){},
            builder: (context,state){
              var profileimage=chatappcubit.get(context).profileimage;

              Namecontroller.text=usermodel.name;
              return Scaffold(
                appBar: AppBar(
                  title: Text('${usermodel.name}',style: TextStyle(fontSize: 15),),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: defaultcolor,
                              child:CircleAvatar(
                                radius: 65,
                                backgroundImage:profileimage ==null? NetworkImage(
                                    '${usermodel.image}'
                                ):FileImage(profileimage)as ImageProvider,

                              ) ,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 130,
                          ),
                          child: Text('${usermodel.name}',style: TextStyle(
                            fontSize: 30,
                          ), maxLines: 3,),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('${usermodel.bio}',style: TextStyle(
                            fontSize: 20
                        ),),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,

                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Chat',
                                style: TextStyle(
                                    fontSize: 30
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: (){
                                  navto(context, chat_details_screen(usermodel: usermodel));
                                },
                                icon: Icon(IconBroken.Chat),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },

          );
        }
    );

  }

}