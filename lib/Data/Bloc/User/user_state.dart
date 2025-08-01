import 'package:ecommerce_app/Data/Model/users/profile_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {
  bool isSignup;
  UserLoadingState({required this.isSignup});
}

class UserSuccessState extends UserState {
  bool isSignup;

  UserSuccessState({required this.isSignup});
}
class UserLoadedState extends UserState{
  ProfileResponse user;
  UserLoadedState({required this.user});
}
class UserFailureState extends UserState {
  String errorMessage;

  UserFailureState({required this.errorMessage});
}
