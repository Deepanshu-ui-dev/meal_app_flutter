import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFvt,
    
  });

  final Meal meal;
  final void Function(Meal meal) onToggleFvt;
  
  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Meal Details',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
             onPressed: () {
                widget.onToggleFvt(widget.meal);
            },
                tooltip: 'Toggle Favorite',
                 icon: const Icon(Icons.star),
               ),

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage(
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(widget.meal.imageUrl),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.meal.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle('Ingredients'),
            _infoCard(
              child: Text(
                widget.meal.ingredients.join(', '),
                style: const TextStyle(color: Colors.white70),
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle('Steps'),
            _infoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.meal.steps
                    .map(
                      (step) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '• $step',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _infoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
