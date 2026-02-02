import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: ListView(
        children: [
          _buildSwitch(
            context: context,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, value);
            },
          ),
          _buildSwitch(
            context: context,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, value);
            },
          ),
          _buildSwitch(
            context: context,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, value);
            },
          ),
          _buildSwitch(
            context: context,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            value: activeFilters[Filter.vegan]!,
            onChanged: (value) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, value);
            },
          ),
        ],
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
