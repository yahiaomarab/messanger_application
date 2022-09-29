class chat_user_model
{
  dynamic image;
  dynamic email;
  dynamic name;
  dynamic uid;
  dynamic bio;
  chat_user_model(
      {
        required this.name,
        required this.email,
        required this.image,
        required this.uid,
        required this.bio,
      }

      );
  chat_user_model.fromjson(Map<String,dynamic>?json)
  {
    name=json!['name'];
    email=json['email'];
    image=json['image'];
    uid=json['uid'];
    bio=json['bio'];
  }
  Map<String,dynamic>toMap()
  {
    return
      {
        'bio':bio,
        'name' :name ,
        'email':email,
        'image':image,
        'uid'  :uid  ,
      };
  }
}