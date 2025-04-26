import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

  final Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    // --> Filtering the meals based on the category
    final filteredMeals =
        dummyMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavorite: onToggleFavorite,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category)).toList()----> another way to do it
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategory(context, category),
          ),
      ],
    );
  }
}
