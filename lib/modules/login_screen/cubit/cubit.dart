import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/modules/login_screen/cubit/states.dart';

class chat_login_cubit extends Cubit<chat_login_state>
{
  chat_login_cubit():super(intialstate());
  static chat_login_cubit get(context)=>BlocProvider.of(context);
 void getUser(
  {
  required String email,
    required String password,
}
     )
 {
 FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
     .then((value) {
       emit(chatloginsuccessstate(value.user!.uid));
 }).catchError((erorr){
       emit(chatloginserorrstate(erorr.toString()));
 });
 }
 bool ischanged=false;
 IconData icona=Icons.visibility_off;
 void changesuffixicon()
 {
   ischanged=!ischanged;
   emit(changeiconpassstate());
 }
}