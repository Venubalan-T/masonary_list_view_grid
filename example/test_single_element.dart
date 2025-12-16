import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masonry_list_view_grid/masonry_list_view_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masonry List View Grid - Single Element Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _itemCount = 1;
  int _columns = 2;
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Single Element Test'),
      ),
      body: Column(
        children: [
          // Controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Items: '),
                    Expanded(
                      child: Slider(
                        value: _itemCount.toDouble(),
                        min: 1,
                        max: 20,
                        divisions: 19,
                        label: _itemCount.toString(),
                        onChanged: (value) {
                          setState(() {
                            _itemCount = value.toInt();
                          });
                        },
                      ),
                    ),
                    Text('$_itemCount'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Columns: '),
                    Expanded(
                      child: Slider(
                        value: _columns.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: _columns.toString(),
                        onChanged: (value) {
                          setState(() {
                            _columns = value.toInt();
                          });
                        },
                      ),
                    ),
                    Text('$_columns'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          // Masonry Grid
          Expanded(
            child: MasonryListViewGrid(
              column: _columns,
              padding: const EdgeInsets.all(8.0),
              children: List.generate(
                _itemCount,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: Color((_random.nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(0.5),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  height: (100 + (index % 3 == 0 ? 50 : 0)).toDouble(),
                  child: Center(
                    child: Text(
                      'Item ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
