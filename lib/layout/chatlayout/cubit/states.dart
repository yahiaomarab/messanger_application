abstract class chatappstates {}
class intialstate extends chatappstates{}
class changebottomitemstate extends chatappstates{}
class changemodestate extends chatappstates{}
class getuserdatasucess extends chatappstates{}
class getuserdataloading extends chatappstates{}
class getuserdataerorr extends chatappstates{
  final String erorr;
  getuserdataerorr(this.erorr);
}
class getAlluserdatasucess extends chatappstates{}
class getAlluserdataloading extends chatappstates{}
class getAlluserdataerorr extends chatappstates{
  final String erorr;
  getAlluserdataerorr(this.erorr);
}
class chatusersstate extends chatappstates{}
class profilepickedsuccess extends chatappstates{}
class profilepickederorr extends chatappstates{}
class imagechatpickedsuccess extends chatappstates{}
class imagechatpickederorr extends chatappstates{}
class imagecamchatpickedsuccess extends chatappstates{}
class imagecamchatpickederorr extends chatappstates{}
class uploadprofilesuccess extends chatappstates{}
class uploadprofileloading extends chatappstates{}
class uploadprofileerorr extends chatappstates{
  final String erorr;
  uploadprofileerorr(this.erorr) ;
}
class updatedatasuccess extends chatappstates{}
class updatedataloading extends chatappstates{}
class updatedataerorr extends chatappstates{
  final String erorr;
  updatedataerorr(this.erorr);
}
class sendmessagesuccess extends chatappstates{}
class sendmessageerorr extends chatappstates{
  final String erorr;
  sendmessageerorr(this.erorr);
}
class getmessageerorr extends chatappstates{
  final String erorr;
  getmessageerorr(this.erorr);
}
class getmessagesuccess extends chatappstates{}
class logoutstate extends chatappstates{}
class lastsuccessmessage extends chatappstates{}
class removechatimage extends chatappstates{}
class sendimagemessageloading extends chatappstates{}
class sendimagemessageerorr extends chatappstates{}
class SocialGetSearchUserSuccessState extends chatappstates{}