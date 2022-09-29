
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class chat_layout_screen extends StatelessWidget
{
var  searchcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(

           create: (BuildContext context)=>chatappcubit(),

           child: BlocConsumer<chatappcubit,chatappstates>(
             listener: (context,state){},
             builder: (context,state){
               return Scaffold(
                 appBar: AppBar(
                   leading:IconButton(
                     onPressed: (){},
                     icon: Icon(Icons.list_outlined),
                   ),
                   title: Text(chatappcubit.get(context).titles[chatappcubit.get(context).currentindex]),
                   actions: [
                     IconButton(
                       onPressed: (){},
                       icon: Icon(Icons.edit),
                     ),
                     IconButton(
                       onPressed: (){},
                       icon: Icon(Icons.camera_alt),
                     ),
                   ],
                 ),
                 body:chatappcubit.get(context).screenapp[chatappcubit.get(context).currentindex] ,
                 bottomNavigationBar: BottomNavigationBar(
                   currentIndex: chatappcubit.get(context).currentindex,
                   onTap: (int index)
                   {
                     chatappcubit.get(context).changebottomitem(index);
                   },
                   items: [
                     BottomNavigationBarItem(
                       icon: Icon(IconBroken.Chat),
                       label: 'chats',
                     ),
                     BottomNavigationBarItem(
                       icon: Icon(IconBroken.User),
                       label: 'people',
                     ),
                     BottomNavigationBarItem(
                       icon: Icon(IconBroken.Setting),
                       label: 'settings',
                     ),
                   ],

                 ),
               );
             },

           ),
         );
  }

}