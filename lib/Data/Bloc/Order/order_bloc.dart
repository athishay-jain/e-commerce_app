import 'package:ecommerce_app/Data/Bloc/Order/order_event.dart';
import 'package:ecommerce_app/Data/Bloc/Order/order_state.dart';
import 'package:ecommerce_app/Data/Model/Product/Order_model.dart';
import 'package:ecommerce_app/Data/Repository/Order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{
  OrderRepo orderRepo;
  OrderBloc({required this.orderRepo}):super(InitialState()){
    on<GetOrderHistory>((event,emit)async{
      final startTime = DateTime.now();
      emit(LoadingState());
      try{
        OrderResponseDataModel response=await orderRepo.getOrder();
        if(response.status){
          final duration = DateTime.now().difference(startTime);
          final minimum = Duration(milliseconds: 500);


          if (duration < minimum) {
            await Future.delayed(minimum - duration);
          }
          emit(LoadedState(orderData: response.orders));
        }else{
          emit(FailureState(errorMessage: response.message));
        }
      }catch(e){
        emit(FailureState(errorMessage: e.toString()));
      }
    });
  }
}