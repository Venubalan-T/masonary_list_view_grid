import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masonry_list_view_grid/masonry_list_view_grid.dart';

void main() {
  testWidgets('masonry list view grid displays single element correctly',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MasonryListViewGrid(
            column: 2,
            children: [
              Container(
                height: 100,
                color: Colors.red,
                child: const Text('Single Item'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the single item is displayed
    expect(find.text('Single Item'), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
  });

  testWidgets('masonry list view grid displays two elements correctly',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MasonryListViewGrid(
            column: 2,
            children: [
              Container(
                height: 100,
                color: Colors.red,
                child: const Text('Item 1'),
              ),
              Container(
                height: 100,
                color: Colors.blue,
                child: const Text('Item 2'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that both items are displayed
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
  });

  testWidgets('masonry list view grid displays three elements with 2 columns',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MasonryListViewGrid(
            column: 2,
            children: [
              Container(
                height: 100,
                color: Colors.red,
                child: const Text('Item 1'),
              ),
              Container(
                height: 100,
                color: Colors.blue,
                child: const Text('Item 2'),
              ),
              Container(
                height: 100,
                color: Colors.green,
                child: const Text('Item 3'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that all three items are displayed
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);
  });

  testWidgets('masonry list view grid displays single element with 3 columns',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MasonryListViewGrid(
            column: 3,
            children: [
              Container(
                height: 100,
                color: Colors.red,
                child: const Text('Single Item'),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the single item is displayed
    expect(find.text('Single Item'), findsOneWidget);
  });

  testWidgets('masonry list view grid displays multiple elements correctly',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MasonryListViewGrid(
            column: 2,
            children: List.generate(
              10,
              (index) => Container(
                height: 100,
                color: Colors.blue,
                child: Text('Item ${index + 1}'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that all 10 items are findable
    for (int i = 1; i <= 10; i++) {
      expect(find.text('Item $i'), findsOneWidget);
    }
  });
}
