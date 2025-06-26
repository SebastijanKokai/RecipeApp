import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/models/data_state.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/repositories/recipe_repository.dart';
import 'package:recipe_app/viewmodels/recipe_viewmodel.dart';
import 'package:recipe_app/widgets/error_view.dart';
import 'package:recipe_app/widgets/loading_view.dart';

class RecipeDetailView extends StatelessWidget {
  final String id;

  const RecipeDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => RecipeViewModel(RecipeRepositoryImpl(), id)..getRecipe(),
      child: Consumer<RecipeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: _RecipeAppBar(viewModel.recipeState),
            body: _RecipeViewContent(viewModel.recipeState),
          );
        },
      ),
    );
  }
}

class _RecipeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RecipeAppBar(this.recipeState);

  final DataState<Recipe> recipeState;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: switch (recipeState) {
        DataSuccess<Recipe>(data: final recipe) => Text(recipe.title),
        _ => const Text('Recipe'),
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _RecipeViewContent extends StatelessWidget {
  const _RecipeViewContent(this.recipeState);

  final DataState<Recipe> recipeState;

  @override
  Widget build(BuildContext context) {
    return switch (recipeState) {
      DataInitial() => const LoadingView(),
      DataLoading() => const LoadingView(),
      DataFailure(message: final message) => ErrorView(message),
      DataSuccess<Recipe>(data: final recipe) => _SuccessView(recipe),
    };
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView(this.recipe);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ServingsCard(servings: recipe.servings),
          const SizedBox(height: 24),
          _IngredientsSection(ingredients: recipe.ingredients),
          const SizedBox(height: 24),
          _InstructionsSection(instructions: recipe.instructions),
        ],
      ),
    );
  }
}

class _ServingsCard extends StatelessWidget {
  final String servings;

  const _ServingsCard({required this.servings});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.people, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text(
              'Servings: $servings',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientsSection extends StatelessWidget {
  final String ingredients;

  const _IngredientsSection({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final ingredientsList = ingredients.split('|');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:
                  ingredientsList.map((ingredient) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 8),
                          const SizedBox(width: 12),
                          Expanded(child: Text(ingredient.trim())),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _InstructionsSection extends StatelessWidget {
  final String instructions;

  const _InstructionsSection({required this.instructions});

  @override
  Widget build(BuildContext context) {
    final instructionsList = instructions.split('. ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:
                  instructionsList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final instruction = entry.value.trim();

                    if (instruction.isEmpty) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text(instruction)),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
