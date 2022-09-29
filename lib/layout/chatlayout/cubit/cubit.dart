

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messanger/layout/chatlayout/cubit/states.dart';
import 'package:messanger/shared/network/local/cache_helper.dart';
import '../../../models/chat_models.dart';
import '../../../models/chat_user_model.dart';
import '../../../modules/chat_users_screen/chat_users_screen.dart';
import '../../../modules/chats/chats.dart';
import '../../../modules/setting_screen/chat_settings_screen.dart';
import '../../../shared/constants/constants.dart';




class chatappcubit extends Cubit<chatappstates> {
  chatappcubit() :super(intialstate());

  static chatappcubit get(context) => BlocProvider.of(context);

  List<Widget>screenapp=[
     chats(),
     chat_users_screen(),
     chat_settings_screen(),
   ];
   List<String>titles=[
     'Chats',
     'Users',
     'Settings'
   ];
   int currentindex=0;
   void changebottomitem(int index)
   {
     currentindex = index;
     if(currentindex == 0){
       GetAllUser();
     }
     if(currentindex == 1){
       GetAllUser();
     }
     if(state is updatedatasuccess){
       GetAllUser();
     }



     emit(changebottomitemstate());
   }
   bool isdark=false;
   Icon ico=Icon(Icons.mode_night);
    changemode({bool? fromshare})
   {
     if (fromshare!= null)

       isdark =  fromshare;

     else
       isdark=!isdark;

     cachehelper.savedata(key: "isdark", value: isdark).then((value) {emit(changemodestate());});
   }
  chat_user_model? usermodel;
  chat_details_model? chatmodel;

  void GetUserData() {
    emit(getuserdataloading());
    FirebaseFirestore.instance
        .collection('chatusers')
        .doc(uid).get()
        .then((value) {
      usermodel = chat_user_model.fromjson(value.data());
      print(value.data());
      emit(getuserdatasucess());
    })
        .catchError((erorr) {
      emit(getuserdataerorr(
          erorr.toString()
      ));
    });
  }

  List<chat_user_model>users = [];

  void GetAllUser() {
    if (users.length == 0)
      try {
        FirebaseFirestore.instance
            .collection('chatusers')
            .snapshots()
            .listen((event) {
              users=[];
              event.docs.forEach((element) {
                users.add(chat_user_model.fromjson(element.data()));
              });
              emit(getAlluserdatasucess());
        });
      } catch (e) {
        print(e.toString());
      }
  }

  var picker = ImagePicker();
  dynamic profileimage;

  Future<void> getprofileimage() async
  {
    var pickedfile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedfile != null) {
      profileimage = File(pickedfile.path);
      emit(profilepickedsuccess());
    } else {
      print('no selected photo');
      emit(profilepickederorr());
    }
  }

  void uploadprofileimage() {
    emit(uploadprofileloading());
    FirebaseStorage.instance
        .ref()
        .child('chatusers/${Uri
        .file(profileimage.path)
        .pathSegments
        .last}')
        .putFile(profileimage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updatauserdata(
          name: usermodel!.name, bio: usermodel!.bio, image: value,);
      }).catchError((erorr) {
        emit(uploadprofileerorr(
            erorr.toString()
        ));
      });
    })
        .catchError((erorr) {
      emit(uploadprofileerorr(erorr.toString()));
    });
  }

  Future<void> updatauserdata({
    required String name,
    required String bio,
    String? image,
  }) async
  {
    chat_user_model model = chat_user_model(
      name: name,
      email: usermodel!.email,
      image: image ?? usermodel!.image,
      uid: usermodel!.uid,
      bio: bio,
    );
    emit(updatedataloading());
    await FirebaseFirestore.instance.collection('chatusers')
        .doc(usermodel!.uid)
        .update(model.toMap()).then((value) {
         GetUserData();
        emit(updatedatasuccess());
    })
        .catchError((erorr) {
      emit(updatedataerorr(erorr.toString()));
    });
  }

  void sendmessage({
    required String text,
    required String reciver,
    required String datatime,
    dynamic chatimage,
  }) {
    chat_details_model model = chat_details_model(
      text: text,
      name: usermodel!.name,
      image: usermodel!.image,
      datatime: datatime,
      reciver: reciver,
      sender: usermodel!.uid,
      chatimage: chatimage ?? '',
    );
    FirebaseFirestore.instance
        .collection('chatusers')
        .doc(usermodel!.uid)
        .collection('chats')
        .doc(reciver)
        .collection('messages')
        .add(model.toMap()).then((value) {
      emit(sendmessagesuccess());
    }).catchError((erorr) {
      emit(sendmessageerorr(erorr.toString()));
    });
    FirebaseFirestore.instance
        .collection('chatusers')
        .doc(reciver)
        .collection('chats')
        .doc(usermodel!.uid)
        .collection('messages')
        .add(model.toMap()).then((value) {
      emit(sendmessagesuccess());
    }).catchError((erorr) {
      emit(sendmessageerorr(erorr.toString()));
    });
  }

  void sendimagemessage({
    required String dataTime,
    required String text,
    required String receiver
  }) {
    try {
      emit(sendimagemessageloading());
      FirebaseStorage.instance.ref()
          .child('messages/${Uri
          .file(chatimage.path)
          .pathSegments
          .last}').
      putFile(chatimage).then((value) {
        value.ref.getDownloadURL().then((value) {
          sendmessage(datatime: dataTime,
              text: text,
              chatimage: value,
              reciver: receiver);
          print(value);
        }).catchError((erorr) {
          emit(sendimagemessageerorr());
        });
      }).catchError((erorr) {
        emit(sendimagemessageerorr());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  List<chat_details_model>message = [];
  List<chat_details_model>lastmessage = [];

  void getmessage({
    required String reciver,
  }) {
    FirebaseFirestore.instance
        .collection('chatusers')
        .doc(usermodel!.uid)
        .collection('chats')
        .doc(reciver)
        .collection('messages')
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(chat_details_model.fromjson(element.data()));
      });
      emit(getmessagesuccess());
    });
  }

  void getlastmessage({
    required String reciver,
  }) {
    FirebaseFirestore.instance
        .collection('chatusers')
        .doc(usermodel!.uid)
        .collection('chats')
        .doc(reciver)
        .collection('messages')
        .get().then((value) {
      value.docs.last.data().forEach((key, value) {
        lastmessage.add(value);
      });
      emit(lastsuccessmessage());
    });
  }

  dynamic chatimage;

  Future<void> getcahtimage() async
  {
    var pickedfile = await picker.pickImage(
        source: ImageSource.gallery
    );
    if (pickedfile != null) {
      chatimage = File(pickedfile.path);
      emit(imagechatpickedsuccess());
    } else {
      print('no selected photo');
      emit(imagechatpickederorr());
    }
  }

  Future<void> getcahtimagecam() async
  {
    var pickedfile = await picker.pickImage(
        source: ImageSource.camera
    );
    if (pickedfile != null) {
      chatimage = File(pickedfile.path);
      emit(imagecamchatpickedsuccess());
    } else {
      print('no selected photo');
      emit(imagecamchatpickederorr());
    }
  }

  void signout() {
    cachehelper.removedata(key: 'uid').then((value) {
      emit(logoutstate());
    });
  }

  removeimage() {
    chatimage = null;
    emit(removechatimage());
  }

  List<chat_user_model> search = [];

  void getSearch(String name) async {
    search = [];
    users.forEach((element) {
      if (element.name.toLowerCase().startsWith(name.toLowerCase())) {
        search.add(element);
      }
      print(search);
    });
    emit(SocialGetSearchUserSuccessState());
  }
}