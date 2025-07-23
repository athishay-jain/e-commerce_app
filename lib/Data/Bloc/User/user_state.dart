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

class UserFailureState extends UserState {
  String errorMessage;

  UserFailureState({required this.errorMessage});
}
