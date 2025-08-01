import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_state.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_event.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_state.dart';
import 'package:ecommerce_app/Data/Model/users/profile_model.dart';
import 'package:ecommerce_app/Data/Repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utilities/Data/app_constants.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository repo;

  UserBloc({required this.repo}) : super(UserInitialState()) {
    on<UserRegistrationEvent>((event, emit) async {
      emit(UserLoadingState(isSignup: true));
      try {
        dynamic user = await repo.signUpUser(newUser: event.userModel);
        print(user);
        if (user["status"]) {
          emit(UserSuccessState(isSignup: true));
        } else {
          emit(UserFailureState(errorMessage: "${user['message']}"));
        }
      } catch (e) {
        emit(UserFailureState(errorMessage: e.toString()));
      }
    });
    on<UserLoginEvent>((event, emit) async {
      emit(UserLoadingState(isSignup: false));
      try {
        dynamic user = await repo.loginUser(
          email: event.email,
          password: event.password,
        );
        if (user["status"]) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.userToken, user["tokan"]);
          emit(UserSuccessState(isSignup: false));
        } else {
          emit(UserFailureState(errorMessage: "${user['message']}"));
        }
      } catch (e) {
        emit(UserFailureState(errorMessage: e.toString()));
      }
    });
    on<GetUserEvent>((event, emit) async {
      emit(UserLoadingState(isSignup: false));
      try {
        ProfileDataResponse response = await repo.getProfile();
        print("the response is${response.message}");
        if (response.status) {
          emit(UserLoadedState(user: response.data));
          print("printed");
        } else {
          emit(UserFailureState(errorMessage: response.message));
        }
      } catch (e) {
        emit(UserFailureState(errorMessage: e.toString()));
      }
    });
  }
}
