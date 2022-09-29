
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../chat_edit_profile/chat_edit_profile.dart';
import '../login_screen/login_screen.dart';

class chat_settings_screen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<chatappcubit,chatappstates>(
      listener: (context,state)
      {
        if(state is changemodestate)
          {
            toastmassage(massege: 'mode changed', state: ToastState.Sucess);
          }
      },
      builder: (context,state){
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            child: Column(
              children: [

                   Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,

                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Mode',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            chatappcubit.get(context).changemode();
                          },
                          icon:chatappcubit.get(context).isdark? Icon(Icons.mode_night):Icon(Icons.mode_night_outlined),
                        ),
                      ],
                    ),
                  ),
                   dividorline(),
                  SizedBox(
                    height: 20,
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
                        'profile',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: (){
                          //chatappcubit.get(context).changemode();
                          navto(context, chat_edit_profile());
                        },
                        icon:Icon(IconBroken.User1),
                      ),
                    ],
                  ),
                ),
                dividorline(),
                SizedBox(
                  height: 20,
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
                        'Logout',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: (){
                          chatappcubit.get(context).signout();

                          navandreplace(context, Chat_login_screen());
                        },
                        icon:Icon(IconBroken.Logout),
                      ),
                    ],
                  ),
                ),
                dividorline(),
              ],
            ),
          ),
        );
      },

    );
  }

}