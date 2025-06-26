import 'package:recipe_app/models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes();
  Future<Recipe> getRecipe(String id);
}

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl._();

  static RecipeRepositoryImpl? _instance;

  factory RecipeRepositoryImpl() {
    _instance ??= RecipeRepositoryImpl._();
    return _instance!;
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    try {
      await Future<dynamic>.delayed(Duration(milliseconds: 500));
      final response = mockRecipes;
      return response.map((json) => Recipe.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to get recipes");
    }
  }

  @override
  Future<Recipe> getRecipe(String id) async {
    try {
      await Future<dynamic>.delayed(Duration(milliseconds: 500));
      final response = mockRecipes.where((recipe) => recipe['id'] == id).first;
      return Recipe.fromJson(response);
    } catch (e) {
      throw Exception("Failed to get recipe");
    }
  }
}

final List<Map<String, dynamic>> mockRecipes = [
  {
    "id": "1",
    "title": "Spaghetti Carbonara",
    "ingredients":
        "1 lb spaghetti|4 large eggs|1/2 cup grated parmesan cheese|4 oz pancetta or bacon, diced|2 cloves garlic, minced|Salt and black pepper to taste|1/4 cup reserved pasta water",
    "servings": "4 servings",
    "instructions":
        "Bring a large pot of salted water to boil. Cook spaghetti according to package directions until al dente. Reserve 1/4 cup of pasta water, then drain pasta. In a large skillet, cook pancetta over medium heat until crispy. Add garlic and cook for 30 seconds. In a bowl, whisk together eggs, parmesan, salt, and pepper. Add hot pasta to skillet with pancetta. Remove from heat and quickly stir in egg mixture, adding reserved pasta water as needed to create a creamy sauce. Serve immediately with extra parmesan and black pepper.",
  },
  {
    "id": "2",
    "title": "Chicken Tikka Masala",
    "ingredients":
        "1.5 lbs chicken breast, cubed|1 cup plain yogurt|2 tbsp tikka masala paste|1 onion, diced|3 cloves garlic, minced|1 inch ginger, grated|1 can (14 oz) crushed tomatoes|1 cup heavy cream|2 tbsp butter|Salt and pepper to taste|Fresh cilantro for garnish",
    "servings": "6 servings",
    "instructions":
        "Marinate chicken in yogurt and 1 tbsp tikka masala paste for 30 minutes. Heat butter in a large skillet over medium heat. Add chicken and cook until browned, about 5-7 minutes. Remove chicken and set aside. In the same skillet, sauté onion until translucent. Add garlic and ginger, cook for 1 minute. Add remaining tikka masala paste and cook for 30 seconds. Add crushed tomatoes and simmer for 10 minutes. Return chicken to skillet and simmer for 15 minutes. Stir in heavy cream and simmer for 5 more minutes. Garnish with cilantro and serve with rice or naan bread.",
  },
  {
    "id": "3",
    "title": "Chocolate Chip Cookies",
    "ingredients":
        "2 1/4 cups all-purpose flour|1 tsp baking soda|1 tsp salt|1 cup (2 sticks) butter, softened|3/4 cup granulated sugar|3/4 cup brown sugar|2 large eggs|2 tsp vanilla extract|2 cups chocolate chips",
    "servings": "24 cookies",
    "instructions":
        "Preheat oven to 375°F (190°C). In a small bowl, whisk together flour, baking soda, and salt. In a large bowl, cream together butter, granulated sugar, and brown sugar until light and fluffy. Beat in eggs one at a time, then stir in vanilla. Gradually mix in the flour mixture until just combined. Fold in chocolate chips. Drop rounded tablespoons of dough onto ungreased baking sheets, spacing them 2 inches apart. Bake for 9-11 minutes or until golden brown. Let cool on baking sheets for 2 minutes, then transfer to wire racks to cool completely.",
  },
  {
    "id": "4",
    "title": "Caesar Salad",
    "ingredients":
        "2 heads romaine lettuce, chopped|1/2 cup parmesan cheese, grated|1 cup croutons|1/4 cup olive oil|2 tbsp lemon juice|1 clove garlic, minced|1 tsp dijon mustard|1/2 tsp worcestershire sauce|Salt and pepper to taste|2 anchovy fillets (optional)",
    "servings": "4 servings",
    "instructions":
        "In a small bowl, whisk together olive oil, lemon juice, garlic, dijon mustard, worcestershire sauce, salt, and pepper to make the dressing. If using anchovies, mash them into the dressing. In a large bowl, combine chopped romaine lettuce with the dressing, tossing gently to coat. Add parmesan cheese and croutons, tossing again. Serve immediately while the lettuce is still crisp.",
  },
  {
    "id": "5",
    "title": "Beef Tacos",
    "ingredients":
        "1 lb ground beef|1 packet taco seasoning|1/2 cup water|8 taco shells|1 cup shredded lettuce|1 cup diced tomatoes|1 cup shredded cheddar cheese|1/2 cup sour cream|1/4 cup salsa|1 avocado, sliced",
    "servings": "4 servings",
    "instructions":
        "In a large skillet over medium heat, cook ground beef until browned, breaking it up with a spoon. Drain excess fat. Add taco seasoning and water, stirring to combine. Simmer for 5 minutes until thickened. Warm taco shells according to package directions. Fill each shell with beef mixture, then top with lettuce, tomatoes, cheese, sour cream, salsa, and avocado slices. Serve immediately.",
  },
];
