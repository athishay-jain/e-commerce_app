import 'package:ecommerce_app/Data/Bloc/User/user_state.dart';
import 'package:ecommerce_app/Data/Model/users/user_model.dart';

abstract class UserEvent {}

class UserRegistrationEvent extends UserEvent {
  UserModel userModel;

  UserRegistrationEvent({required this.userModel});
}

class UserLoginEvent extends UserEvent {
  String email;
  String password;

  UserLoginEvent({required this.email, required this.password});
}
class GetUserEvent extends UserEvent{}
