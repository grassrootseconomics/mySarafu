import 'package:flutter/material.dart';

class AutocompleteWidget<T extends Object> extends StatelessWidget {
  const AutocompleteWidget({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.search,
    required this.displayStringForOption,
  }) : super(key: key);
  final Iterable<T> options;
  final void Function(T value) onSelected;
  final Iterable<T> Function(String searchString, Iterable<T> options) search;
  final String Function(T) displayStringForOption;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Autocomplete<T>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return Iterable<T>.empty();
          }
          return search(textEditingValue.text, options);
        },
        displayStringForOption: displayStringForOption,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) =>
                TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (_) => onFieldSubmitted(),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Token',
          ),
        ),
        onSelected: (T selection) {
          onSelected(selection);
          debugPrint('You just selected $selection');
        },
      ),
    );
  }
}
