[![Pub][pub_badge]][pub]

# masonry_list_view_grid
Provides a masonry grid layout using list view.

Layout handles large number of children, since it uses list view like dynamic rendering.

![masonry_list_view_grid (3)](https://github.com/Venubalan-T/masonary_list_view_grid/assets/91170720/c72f2ae5-68ec-4dd0-934b-5cfdf87031ee)



## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  masonry_list_view_grid: <latest_version>
```

In your library add the following import:

```dart
import 'package:masonry_list_view_grid/masonry_list_view_grid.dart';
```

For help getting started with Flutter, view the online [documentation][flutter_documentation].

## Usage

```dart
MasonryListViewGrid(
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
```
## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue][issue].  
If you fixed a bug or implemented a feature, please send a [pull request][pr].

<!-- Links -->
[pub_badge]: https://img.shields.io/pub/v/masonry_list_view_grid.svg
[pub]: https://pub.dartlang.org/packages/masonry_list_view_grid
[issue]: https://github.com/Venubalan-T/masonary_list_view_grid/issues
[pr]: https://github.com/Venubalan-T/masonary_list_view_grid/pulls
[flutter_documentation]: https://docs.flutter.dev/
