abstract class chat_login_state {}
class intialstate extends chat_login_state{}
class chatloginsuccessstate extends chat_login_state{
  final String uId;
  chatloginsuccessstate(this.uId) ;
}
class chatloginserorrstate extends chat_login_state{
  final String erorr;
  chatloginserorrstate(this.erorr);
}
class changeiconpassstate extends chat_login_state{

}