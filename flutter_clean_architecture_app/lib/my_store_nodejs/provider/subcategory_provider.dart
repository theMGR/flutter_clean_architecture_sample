import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flearn/my_store_nodejs/models/subcategory.dart';

final subcategoryProvider = StateNotifierProvider<SubcategoryNotifier, List<Subcategory>>((ref) {
  return SubcategoryNotifier();
});

class SubcategoryNotifier extends StateNotifier<List<Subcategory>> {
  SubcategoryNotifier() : super([]);

  void setSubcategories(List<Subcategory> subcategories) {
    state = subcategories;
  }
}
