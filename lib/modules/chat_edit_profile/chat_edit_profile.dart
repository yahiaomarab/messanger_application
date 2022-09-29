import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../shared/component/components.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';

class chat_edit_profile extends StatelessWidget
{
  var Namecontroller=TextEditingController();
  var Biocontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<chatappcubit,chatappstates>(
      listener: (context,state){},
      builder: (context,state){
        var profileimage=chatappcubit.get(context).profileimage;
          var usermodel=chatappcubit.get(context).usermodel;
        Namecontroller.text=usermodel!.name;
        Biocontroller.text=usermodel.bio;
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: (){
               chatappcubit.get(context).updatauserdata(name: Namecontroller.text,bio: Biocontroller.text);
                },
                child: Text(
                  'update',
                  style: TextStyle(
                      color: defaultcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(state is updatedataloading)
                    LinearProgressIndicator(),
                  if(state is updatedataloading)
                    SizedBox(
                      height: 5,
                    ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: defaultcolor,
                        child:CircleAvatar(
                          radius: 60,
                          backgroundImage:profileimage ==null? NetworkImage(
        '${usermodel.image}'
        ):FileImage(profileimage)as ImageProvider,

                        ) ,
                      ),
                      IconButton(
                        onPressed: (){
                          chatappcubit.get(context).getprofileimage();
                        },
                        icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: defaultcolor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  if(chatappcubit.get(context).profileimage !=null)
                    Column(
                      children: [
                        button(x: 40, text: 'update profile', OnPressed: (){
                          chatappcubit.get(context).uploadprofileimage();
                        }, width: double.infinity),
                        if(state is updatedataloading)
                          SizedBox(
                            height: 3,
                          ),
                        if(state is updatedataloading)
                          LinearProgressIndicator(),
                      ],
                    ),
                  if(chatappcubit.get(context).profileimage !=null)
                   SizedBox(
                    height: 20,
                  ),
                  formfield(
                    controller: Namecontroller,
                    type: TextInputType.name,
                    validate: (String? value){},
                    label: 'name',
                    prefix: IconBroken.User,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  formfield(
                    controller: Biocontroller,
                    type: TextInputType.text,
                    validate: (String? value){},
                    label: 'bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }

}