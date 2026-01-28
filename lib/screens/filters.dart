import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters[Filter.glutenFree] ?? false;
    _isLactoseFree = widget.currentFilters[Filter.lactoseFree] ?? false;
    _isVegan = widget.currentFilters[Filter.vegan] ?? false;
    _isVegetarian = widget.currentFilters[Filter.vegetarian] ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegan: _isVegan,
            Filter.vegetarian: _isVegetarian,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFree,
              onChanged: (value) {
                setState(() {
                  _isGlutenFree = value;
                });
              },
              title: const Text('Gluten-Free'),
              subtitle: const Text('Only include gluten-free meals.'),
            ),
            SwitchListTile(
              value: _isLactoseFree,
              onChanged: (value) {
                setState(() {
                  _isLactoseFree = value;
                });
              },
              title: const Text('Lactose-Free'),
              subtitle: const Text('Only include lactose-free meals.'),
            ),
            SwitchListTile(
              value: _isVegan,
              onChanged: (value) {
                setState(() {
                  _isVegan = value;
                });
              },
              title: const Text('Vegan'),
              subtitle: const Text('Only include vegan meals.'),
            ),
            SwitchListTile(
              value: _isVegetarian,
              onChanged: (value) {
                setState(() {
                  _isVegetarian = value;
                });
              },
              title: const Text('Vegetarian'),
              subtitle: const Text('Only include vegetarian meals.'),
            ),
          ],
        ),
      ),
    );
  }
}
