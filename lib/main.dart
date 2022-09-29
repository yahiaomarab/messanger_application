
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/shared/constants/constants.dart';
import 'package:messanger/shared/network/local/cache_helper.dart';
import 'package:messanger/shared/styles/themes.dart';

import 'layout/chatlayout/chat_layout.dart';
import 'layout/chatlayout/cubit/cubit.dart';
import 'layout/chatlayout/cubit/states.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';
import 'modules/register_screen/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await  cachehelper.init();
  Widget startwidget;
  uid=cachehelper.Gettdata(key: 'uid');
  bool onboarding=cachehelper.Gettdata(key: 'boarding');
  bool isDark=cachehelper.Gettdata(key: 'isdark');
  if (onboarding==true )
  {
    if(uid !=null)
    {
      startwidget=  chat_layout_screen();
    }else
    {
      startwidget=Chat_login_screen();
    }

  }else
    startwidget=onBoarding_screen();
  print(uid);
  print(onboarding);
  print(isDark);
  runApp( MyApp(
      startwidget,isDark
  ));
}

class MyApp extends StatelessWidget
{
  final Widget startwidget;
  final bool isDark;
  MyApp(this.startwidget,this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context)=>
            chatappcubit()
           .. GetAllUser()
              ..GetUserData()
                        ..changemode(
                           fromshare: isDark,
                         )
        )
      ],
      child: BlocConsumer<chatappcubit,chatappstates>(
        listener: (context,state){},
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: chatappcubit.get(context).isdark? ThemeMode.dark:ThemeMode.light,
            home:startwidget,
          );
        },

      ),
    );
  }

}
