import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Gluten-free'),
            value: true,
            onChanged: (newValue) {},
            subtitle: const Text('Only include gluten-free meals'),
          ),
        ],
      ),
    );
  }
}
