


//login
class AuthenticationModel
{
  CustomerModel? customerModel;
  ContactsModel? contactsModel;
  AuthenticationModel({required this.contactsModel,required this.customerModel});
}
class CustomerModel
{
  String name;
  String id;
  int numOfNotifications;
  CustomerModel({required this.name, required this.id, required this.numOfNotifications});
}
class ContactsModel
{
  String phone;
  String email;
  String link;
  ContactsModel({required this.link,required this.email,required this.phone,});
}