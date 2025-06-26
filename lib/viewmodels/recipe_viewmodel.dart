import 'package:flutter/material.dart';
import 'package:recipe_app/utils/data_state.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/repositories/recipe_repository.dart';

class RecipeViewModel extends ChangeNotifier {
  RecipeViewModel(this._recipeRepository, this._id);

  final RecipeRepository _recipeRepository;
  final String _id;

  DataState<Recipe> _recipeState = DataInitial();
  DataState<Recipe> get recipeState => _recipeState;

  Future<void> getRecipe() async {
    try {
      _recipeState = DataLoading();
      notifyListeners();

      final response = await _recipeRepository.getRecipe(_id);

      _recipeState = DataSuccess(response);
      notifyListeners();
    } catch (e) {
      _recipeState = DataFailure(e.toString());
      notifyListeners();
    }
  }
}
