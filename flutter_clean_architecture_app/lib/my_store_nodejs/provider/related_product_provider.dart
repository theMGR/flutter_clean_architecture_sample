import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flearn/my_store_nodejs/models/product.dart';

class RelatedProductProvider extends StateNotifier<List<Product>> {
  RelatedProductProvider() : super([]);

  //set the list of products
  void setProducts(List<Product> products) {
    state = products;
  }
}

final relatedProductProvider =
    StateNotifierProvider<RelatedProductProvider, List<Product>>((ref) {
  return RelatedProductProvider();
});
