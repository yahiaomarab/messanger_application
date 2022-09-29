
class chat_details_model
{
  dynamic text;
  dynamic datatime;
  dynamic sender;
  dynamic reciver;
  dynamic image;
  dynamic name;
  dynamic chatimage;
 chat_details_model.fromjson(Map<String,dynamic>?json)
 {
   text=json!['text'];
   datatime=json['datatime'];
   sender=json['sender'];
   reciver=json['reciver'];
   image=json['image'];
   name=json['name'];
   chatimage=json['chatimage'];
 }
 chat_details_model(
  {
    required this.text,
    required this.name,
    required this.image,
    required this.datatime,
    required this.reciver,
    required this.sender,
    required this.chatimage,
}
     );
Map<String,dynamic>toMap()
  {
    return
        {
          'text':text,
          'name':name,
          'image':image,
          'datatime':datatime,
          'sender':sender,
          'reciver':reciver,
          'chatimage':chatimage,
        };
}
}