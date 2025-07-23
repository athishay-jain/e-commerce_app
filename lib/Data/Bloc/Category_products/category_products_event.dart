abstract class CategoryProductsEvent {}

class LoadProducts extends CategoryProductsEvent {
  String cat_id;

  LoadProducts({required this.cat_id});
}
