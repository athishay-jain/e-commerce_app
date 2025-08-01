import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_event.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_state.dart';
import 'package:ecommerce_app/Data/Model/Product/cart_model.dart';
import 'package:ecommerce_app/Data/Repository/cart_repo.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepo cartRepo;

  CartBloc({required this.cartRepo}) : super(InitialState()) {
    on<AddToCart>((event, emit) async {
      emit(LoadingState());
      try {
        dynamic res = await cartRepo.AddToCart(
          productId: event.product_id,
          qty: event.quantity,
        );
        print(res);
        if (res["status"] == "true") {
          emit(SuccessState(message: res["message"]));
        } else if (res["status"]) {
          emit(SuccessState(message: res["message"]));
        } else {
          emit(FailureState(errorMessage: res["message"]));
        }
        print(res);
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
        print(e.toString());
      }
    });
    on<GetCart>((event, emit) async {
      emit(LoadingState());
      try {
        CartDataModel cart = await cartRepo.getCart();
        if (cart.status) {
            emit(
              LoadedState(
                cart: cart.data,
                totalAmount: findTotalAmount(cart: cart.data),
                message: "",
              ),
            );
        } else if(cart.message=="Cart data not found"){
          emit(CartEmptyState());
        }

        else {
          emit(FailureState(errorMessage: cart.message));
        }
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });
    on<DeleteItem>((event, emit) async {
      emit(LoadingState());
      try {
        dynamic res = await cartRepo.deleteItem(cart_id: event.cart_id);
        if (res["status"]) {
          CartDataModel view = await cartRepo.getCart();
          if (view.status) {
            emit(
              LoadedState(
                cart: view.data,
                totalAmount: findTotalAmount(cart: view.data),
                message: res["message"],
              ),
            );
          } else if(view.message=="Cart data not found"){
            emit(CartEmptyState());
          }

          else {
            emit(FailureState(errorMessage: view.message));
          }
        } else {
          emit(FailureState(errorMessage: res["message"]));
        }
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });
    on<IncrementQty>((event, emit) async {
      try {
        dynamic res = await cartRepo.AddToCart(
          productId: event.product_id,
          qty: event.quantity,
        );
        print(res);
        if (res["status"] == "true" || res["status"]) {
          CartDataModel cart = await cartRepo.getCart();
          if (cart.status) {
            print(cart.data);
            emit(
              LoadedState(
                cart: cart.data,
                totalAmount: findTotalAmount(cart: cart.data),
                message: res["message"],
              ),
            );
          } else {
            emit(FailureState(errorMessage: cart.message));
          }
        } else {
          emit(FailureState(errorMessage: res["message"]));
        }
        print(res);
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });
    on<DecrementQty>((event, emit) async {
      try {
        dynamic res = await cartRepo.decrementItem(
          product_id: event.product_id,
          qty: event.quantity,
        );
        print(res);
        if (res["status"] == "true" || res["status"]) {
          CartDataModel cart = await cartRepo.getCart();
          if (cart.status) {
            emit(
              LoadedState(
                cart: cart.data,
                totalAmount: findTotalAmount(cart: cart.data),
                message: res["message"],
              ),
            );
          } else if(cart.message=="Cart data not found"){
            emit(CartEmptyState());
          }

          else {
            emit(FailureState(errorMessage: cart.message));
          }
        } else {
          emit(FailureState(errorMessage: res["message"]));
        }
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });
    on<PlaceOrder>((event, emit) async {
      emit(OrderLoadingState());
      try {
        dynamic res = await cartRepo.placeOrder(cart_id: event.cart_id);
        emit(OrderLoadedState(message: res["message"], success: res["status"]));
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });
  }

  int findTotalAmount({required List<CartModel> cart}) {
    int total = 0;
    for (CartModel eachCart in cart) {
      total += int.parse(eachCart.price) * eachCart.quantity;
    }
    return total;
  }
}
