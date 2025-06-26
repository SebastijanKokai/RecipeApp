class Recipe {
  final String id;
  final String title;
  final String ingredients;
  final String servings;
  final String instructions;

  const Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.servings,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      ingredients: json['ingredients'] ?? '',
      servings: json['servings'] ?? '',
      instructions: json['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'servings': servings,
      'instructions': instructions,
    };
  }

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, servings: $servings)';
  }
}
