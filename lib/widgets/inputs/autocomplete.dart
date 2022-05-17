import 'package:flutter/material.dart';

class AutocompleteWidget<T extends Object> extends StatelessWidget {
  const AutocompleteWidget({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.search,
  }) : super(key: key);
  final Iterable<T> options;
  final void Function(T value) onSelected;
  final Iterable<T> Function(String searchString, Iterable<T> options) search;
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return Iterable<T>.empty();
        }
        return search(textEditingValue.text, options);
      },
      onSelected: (T selection) {
        onSelected(selection);
        debugPrint('You just selected $selection');
      },
    );
  }
}
