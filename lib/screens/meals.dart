import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_details.dart';
import 'package:meal_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFvt,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFvt;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFvt: onToggleFvt,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (meals.isEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Uh oh… nothing here!',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: Colors.white) ??
                    const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Try selecting a different category.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70) ??
                    const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      );
    } else {
      content = ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) => _selectMeal(context, meal),
        ),
      );
    }

    // Used inside TabsScreen
    if (title == null) {
      return content;
    }

    // Used via Navigator.push
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title!),
      ),
      body: content,
    );
  }
}
