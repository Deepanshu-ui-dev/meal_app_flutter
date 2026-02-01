import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  late bool _glutenFree;
  late bool _lactoseFree;
  late bool _vegetarian;
  late bool _vegan;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);

    _glutenFree = activeFilters[Filter.glutenFree]!;
    _lactoseFree = activeFilters[Filter.lactoseFree]!;
    _vegetarian = activeFilters[Filter.vegetarian]!;
    _vegan = activeFilters[Filter.vegan]!;
  }

  void _saveFilters() {
    ref.read(filtersProvider.notifier).setFilters({
      Filter.glutenFree: _glutenFree,
      Filter.lactoseFree: _lactoseFree,
      Filter.vegetarian: _vegetarian,
      Filter.vegan: _vegan,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if (!didPop) return;
          _saveFilters();
        },
        child: ListView(
          children: [
            _buildSwitch(
              context: context,
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              value: _glutenFree,
              onChanged: (value) {
                setState(() {
                  _glutenFree = value;
                });
              },
            ),
            _buildSwitch(
              context: context,
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              value: _lactoseFree,
              onChanged: (value) {
                setState(() {
                  _lactoseFree = value;
                });
              },
            ),
            _buildSwitch(
              context: context,
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              value: _vegetarian,
              onChanged: (value) {
                setState(() {
                  _vegetarian = value;
                });
              },
            ),
            _buildSwitch(
              context: context,
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              value: _vegan,
              onChanged: (value) {
                setState(() {
                  _vegan = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
