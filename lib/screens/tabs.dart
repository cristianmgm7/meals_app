import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/filter.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/providers/favorites.provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals =
        meals.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Widget activePage = CategoriesScreen(meals: availableMeals);
    var activePageTitle = 'Categories';

    if (_selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoritesProvider);
      activePage = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    void selectScreen(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
          ),
        );
        if (result != null) {
          setState(() {
            _selectedFilters = result;
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: selectScreen),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
