import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger/shared/network/local/cache_helper.dart';
import '../../layout/chatlayout/chat_layout.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/icon_broken.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class Chat_login_screen extends StatelessWidget
{
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=> chat_login_cubit(),
      child: BlocConsumer<chat_login_cubit,chat_login_state>(
        listener: (context,state){
          if (state is chatloginserorrstate)
          {
            toastmassage(
                massege: state.erorr,
                state: ToastState.Erorr
            );
          }
          else if(state is chatloginsuccessstate)
          {
            cachehelper.savedata(key: 'uid', value:state.uId).then((value) {
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
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Welcome To Our Global',
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
                                    suffix: chat_login_cubit.get(context).ischanged?Icons.visibility_off:Icons.visibility,
                                    onSuffixPressed: (){
                                      chat_login_cubit.get(context).changesuffixicon();
                                    },
                                      isPassword:chat_login_cubit.get(context).ischanged,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Dont have an account?'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          navto(context, chat_register_screen());
                                        },
                                        child: Text(
                                          'REGISTER',

                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  button(
                                    x: 40,
                                    text: 'Login',
                                    OnPressed: (){
                                      if(formkey.currentState!.validate())
                                        {
                                          chat_login_cubit.get(context).getUser(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                          );
                                        }
                                    },
                                    width: 100,
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