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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Masonry List View Grid'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: MasonryListViewGrid(
        column: 2,
        padding: const EdgeInsets.all(8.0),
        children: List.generate(
          100,
          (index) => Container(
            decoration: BoxDecoration(
              color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.5),
            ),
            height: (150 + (index % 3 == 0 ? 50 : 0)).toDouble(),
            child: Center(
              child: Text('Child ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }
}
