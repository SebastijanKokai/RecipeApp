import 'package:flutter/material.dart';
import 'package:recipe_app/utils/data_state.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/repositories/recipe_repository.dart';

class RecipeOverviewViewModel extends ChangeNotifier {
  RecipeOverviewViewModel(this._recipeRepository);

  final RecipeRepository _recipeRepository;

  DataState<List<Recipe>> _recipesState = DataInitial();
  DataState<List<Recipe>> get recipesState => _recipesState;

  Future<void> getRecipes() async {
    try {
      _recipesState = DataLoading();
      notifyListeners();

      final recipes = await _recipeRepository.getRecipes();

      _recipesState = DataSuccess(recipes);
      notifyListeners();
    } catch (e) {
      _recipesState = DataFailure(e.toString());
      notifyListeners();
    }
  }
}
