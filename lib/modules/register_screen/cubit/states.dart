abstract class chat_appregister_states {}
class intialstate extends chat_appregister_states{}
class registerusersuccessstate extends chat_appregister_states{
  final String uid;
  registerusersuccessstate(this.uid);
}
class registeruserloadingstate extends chat_appregister_states{}
class registerusererorrstate extends chat_appregister_states{
  final String erorr;
  registerusererorrstate(this.erorr);
}
class registercreateusersuccessstate extends chat_appregister_states{}
class registercreateuserloadingstate extends chat_appregister_states{}
class registercreateusererorrstate extends chat_appregister_states{
  final String erorr;
  registercreateusererorrstate(this.erorr);
}
class registerchangeiconpasswordstate extends chat_appregister_states{}
