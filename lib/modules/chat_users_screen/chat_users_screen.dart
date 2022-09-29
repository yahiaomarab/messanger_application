
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/chatlayout/cubit/cubit.dart';
import '../../layout/chatlayout/cubit/states.dart';
import '../../models/chat_user_model.dart';
import '../../shared/component/components.dart';
import '../chat_details_screen/chat_detealis.dart';

class chat_users_screen extends StatelessWidget
{
  @override


 Widget build(BuildContext context) {
    return BlocConsumer<chatappcubit,chatappstates>(
      listener: (context,state){
        if(state is getAlluserdatasucess)
          {
            toastmassage(massege: 'success', state: ToastState.Sucess);
          }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: chatappcubit.get(context).users.length>0,
          builder: (context)=>Scaffold(
            body:ListView.separated(
              itemBuilder: (context,index)=>builtusers(context,chatappcubit.get(context).users[index]),
              separatorBuilder: (context,index)=>SizedBox(
                height: 10,
              ),
              itemCount:  chatappcubit.get(context).users.length,
            ) ,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
Widget builtusers(context,chat_user_model model)
{
  return InkWell(
    onTap: (){
      navto(context, chat_details_screen(
        usermodel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,

            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${model.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}