## Features

Provides a masonry grid layout using list view.

## Usage

```dart
const children = [
    'child 1',
    'child 2',
    'child 3',
    'child 4',
    'child 5',
    'child 6',
    'child 7',
    'child 8',
    'child 9',
    'child 10',
];

MasonryGrid(
    column: 2,
    padding: EdgeInsets.all(8.0),
    children: List.generate(
        children.length,
        (index) => Container(
            child: Text(children[index]),
        ),
    ),
)
```
