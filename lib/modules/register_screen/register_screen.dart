import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/shared/network/local/cache_helper.dart';
import '../../layout/chatlayout/chat_layout.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class chat_register_screen extends StatelessWidget
{
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=> chat_appregister_cubit(),
      child: BlocConsumer<chat_appregister_cubit,chat_appregister_states>(
        listener: (context,state){
          if(state is registerusersuccessstate)
          {
            cachehelper.savedata(key: 'uid', value:state.uid).then((value) {
              toastmassage(
                massege: 'تم تسجيل الدخول بنجاح',
                state: ToastState.Sucess,
              );
              navandreplace(context, chat_layout_screen());
            });
          }
        },
        builder: (context,state)=>Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: Center(
              child: Form(
                key: formkey,
                child: Column(

                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Register Now To Chat With Your Firends',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70),
                                topRight: Radius.circular(70),
                              ),
                              color: Colors.grey,
                            ),

                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 100,
                              horizontal: 20,
                            ),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  formfield(
                                    controller: emailcontroller,
                                    type: TextInputType.emailAddress,
                                    validate: (String? value){
                                      if(value!.isEmpty)
                                        return 'you must write email';
                                      else
                                        return null;
                                    },
                                    label: 'Enter Your Email Address',
                                    prefix: Icons.email_outlined,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  formfield(
                                    controller: passwordcontroller,
                                    type: TextInputType.visiblePassword,
                                    validate: (String? value){
                                      if(value!.isEmpty)
                                        return 'you must write password';
                                      else
                                        return null;
                                    },
                                    label: 'Enter Your Password',

                                    prefix: IconBroken.Password,
                                    suffix: chat_appregister_cubit.get(context).ischanged?Icons.visibility_off:Icons.visibility,
                                    onSuffixPressed: (){
                                      chat_appregister_cubit.get(context).changesuffixicon();
                                    },
                                    isPassword:chat_appregister_cubit.get(context).ischanged,
                                  ),

                                  SizedBox(
                                    height: 40,
                                  ),
                                  formfield(
                                    controller: phonecontroller,
                                    type: TextInputType.phone,
                                    validate: (String? value){
                                      if(value!.isEmpty)
                                        return 'you must write phone';
                                      else
                                        return null;
                                    },
                                    label: 'Enter Your Phone Number',
                                    prefix: Icons.phone,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  formfield(
                                    controller: namecontroller,
                                    type: TextInputType.emailAddress,
                                    validate: (String? value){
                                      if(value!.isEmpty)
                                        return 'you must write name';
                                      else
                                        return null;
                                    },
                                    label: 'Enter Your Name',
                                    prefix: IconBroken.User,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),

                                  ConditionalBuilder(
                                    condition:  state is! registeruserloadingstate,
                                    builder:(context) =>button(
                                      x: 40,
                                      text: 'Register',
                                      OnPressed: (){
                                        if(formkey.currentState!.validate())
                                        {
                                         chat_appregister_cubit.get(context).chatuserregister(
                                             email: emailcontroller.text,
                                             password: passwordcontroller.text,
                                             phone: phonecontroller.text,
                                             name: namecontroller.text,
                                           bio: 'hey im using massenger',
                                         );
                                        }
                                      },
                                      width: 100,
                                    ),
                                    fallback: (context)=>Center(child: CircularProgressIndicator()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}