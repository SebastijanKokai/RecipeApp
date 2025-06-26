import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/data_state.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/repositories/recipe_repository.dart';
import 'package:recipe_app/viewmodels/recipe_overview_viewmodel.dart';
import 'package:recipe_app/widgets/error_view.dart';
import 'package:recipe_app/widgets/loading_view.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

class RecipeOverview extends StatelessWidget {
  const RecipeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe overview")),
      body: ChangeNotifierProvider(
        create:
            (BuildContext context) =>
                RecipeOverviewViewModel(RecipeRepositoryImpl())..getRecipes(),
        child: _RecipeOverview(),
      ),
    );
  }
}

class _RecipeOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeOverviewViewModel>(
      builder: (context, viewModel, child) {
        return switch (viewModel.recipesState) {
          DataInitial() => LoadingView(),
          DataLoading() => LoadingView(),
          DataFailure(message: final message) => ErrorView(message),
          DataSuccess(data: final recipes) => _SuccessView(recipes),
        };
      },
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView(this.recipes);

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) => RecipeCard(recipe: recipes[index]),
    );
  }
}
