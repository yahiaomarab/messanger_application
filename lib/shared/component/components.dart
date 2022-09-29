import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../modules/chat_otheruser_profile/chat_otherusers_profile.dart';
import '../styles/colors.dart';

Future<void> navto(context,Widget)
async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>Widget),
  );

}
void navandreplace(context,Widget)
{
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>Widget),
        (Route<dynamic>route)=>false,
  );
}
Future <bool?> toastmassage({
  required String massege,
  required ToastState state,
})
{
  return Fluttertoast.showToast(
      msg:'$massege',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choosetoastcolor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastState{Erorr,Sucess,Warning}
Color choosetoastcolor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.Sucess:
      color=  Colors.green;
      break;
    case ToastState.Erorr:
      color= Colors.red ;
      break;
    case ToastState.Warning:
      color=Colors.blue;
      break;
  }
  return color;
}
PreferredSizeWidget buildappbar(
    {
      required BuildContext context,
      String? title,
      List<Widget>?actions,
    }
    )=>AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon:Icon(Icons.arrow_back_ios_new_outlined),
  ),
  title: Text(title!),
  actions: actions,
);
Widget formfield (
    {
      required TextEditingController controller ,
      required TextInputType type ,
      Function(String)? onSubmit ,
      VoidCallback? onTap ,
      Function(String)? onChanged ,
      required String? Function(String?)? validate ,
      required String label ,
      IconData? prefix ,
      IconData? suffix = null ,
      bool isPassword = false,
      bool isClickable = true ,
      VoidCallback? onSuffixPressed ,

    }) => TextFormField(
  validator: validate,
  obscureText: isPassword,
  controller: controller,
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix ,),
      suffixIcon: GestureDetector(
        child: Icon(suffix),
        onTap: onSuffixPressed,
      ),
      border: OutlineInputBorder()
  ),
  keyboardType: type,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  onTap: onTap,

) ;
Widget button(
    {
      required double x,
      required String text,
      required OnPressed,
      required double width,
    }
    )
{
  return Container(
    color: Colors.grey[400],
    width: width,
    height: x,
    child: MaterialButton(


      onPressed: OnPressed,
      child: Text(
        text,
        style: TextStyle(
          color:Colors.black,
        ),
      ),

    ),
  )  ;
}
Widget dividorline()
{
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
      top: 20,
      bottom: 10,
    ),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey[300],
    ),
  );
}
Widget buildSearchItem(list ,context)
{
 return InkWell(
   onTap: (){
     navto(context, chat_otherusers_profile(usermodel: list));
   },
   child: Row(
     children: [
       InkWell(
         onTap: (){

         },
         child: Row(
           children: [
             CircleAvatar(
               radius: 27,

               backgroundImage: NetworkImage('${list.image}'),
             ),
             SizedBox(
               width: 10,
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   '${list.name}',
                   style: Theme.of(context).textTheme.bodyText1,
                 ),
                 SizedBox(height: 5,),
               ],
             ),
           ],
         ),
       )
     ],
   ),
 );
}
