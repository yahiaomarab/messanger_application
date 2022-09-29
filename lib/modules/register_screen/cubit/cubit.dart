import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/modules/register_screen/cubit/states.dart';
import '../../../models/chat_user_model.dart';

class chat_appregister_cubit extends Cubit<chat_appregister_states>
{
  chat_appregister_cubit():super(intialstate());
  static chat_appregister_cubit get(context)=>BlocProvider.of(context);
  chatuserregister(
  {
    required String email,
    required String password,
    required String phone,
    required String name,
    required String bio,
}
      )
  {
   FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
       .then((value) {
         chatcreateuserregister(email: email, uid: value.user!.uid, phone: phone, name: name,bio:bio);
         emit(registerusersuccessstate(value.user!.uid));
   }).catchError((erorr){
     emit(registerusererorrstate(erorr.toString()));
   });
  }
  chatcreateuserregister(
  {
  required String email,
  required String uid,
  required String phone,
  required String name,
    required String bio,
  }
      )
  {
    emit(registercreateuserloadingstate());
    chat_user_model model=chat_user_model(
        name: name,
        email: email,
      image: 'https://scontent.fcai21-1.fna.fbcdn.net/v/t39.30808-6/280265193_1342616946260193_982784802929741640_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFdrFi7OtrlnnDZV2HD-hcXP_PbuiCVJrg_89u6IJUmuDicN6TKekBSpFujJZZZB0QhXOeXtnIJFIC2G5hz7Wjh&_nc_ohc=etuDu24WO74AX9_vLwF&_nc_ht=scontent.fcai21-1.fna&oh=00_AT9rbjzPZwsRi5_l5mKIOhhRRia9mwlTnDSLSrgpaUa9zg&oe=62E76E0F',
      uid: uid,
      bio: 'hello world im using app',
    );
    FirebaseFirestore.instance.collection('chatusers')
    .doc(uid)
    .set(model.toMap())
    .then((value) {
      emit(registercreateusersuccessstate());
    })
    .catchError((erorr){
      emit(registercreateusererorrstate(erorr.toString()));
    });
  }
  bool ischanged=false;
  IconData icona=Icons.visibility_off;
  void changesuffixicon()
  {
    ischanged=!ischanged;
    emit(registerchangeiconpasswordstate());
  }
}