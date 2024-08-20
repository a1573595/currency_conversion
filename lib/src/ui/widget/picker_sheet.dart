import 'package:currency_conversion/src/ui/l10n/l10n.dart';
import 'package:currency_conversion/src/ui/style/widget_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showPickerSheet<T>(
  BuildContext context, {
  required Map<T, String> children,
  T? initialValue,
}) {
  FocusManager.instance.primaryFocus?.unfocus();

  return showCupertinoModalPopup(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WidgetStyle.p4,
        vertical: WidgetStyle.p8,
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: SafeArea(
        top: false,
        child: _Picker(
          children,
          initialValue ?? children.keys.first,
        ),
      ),
    ),
  );
}

class _Picker<T> extends StatefulWidget {
  const _Picker(this.children, this.initialValue, {super.key});

  final Map<T, String> children;
  final T initialValue;

  @override
  State<_Picker<T>> createState() => _PickerState<T>();
}

class _PickerState<T> extends State<_Picker<T>> {
  late T _selectedItem;

  late final FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();

    _selectedItem = widget.initialValue;

    final value = widget.children.keys.toList().indexOf(widget.initialValue);
    final initialIndex = value == -1 ? 0 : value;

    _controller = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final itemExtent = Theme.of(context).textTheme.titleMedium!.fontSize! + WidgetStyle.p16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(
                L10n.current.cancel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(_selectedItem),
              child: Text(
                L10n.current.save,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: itemExtent * 7,
          child: ScrollConfiguration(
            behavior: const CupertinoScrollBehavior(),
            child: CupertinoPicker(
              scrollController: _controller,
              useMagnifier: true,
              itemExtent: itemExtent,
              squeeze: WidgetStyle.pickerSqueeze,
              magnification: WidgetStyle.pickerMagnification,
              selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                background: Theme.of(context).highlightColor,
              ),
              onSelectedItemChanged: (value) => _selectedItem = widget.children.keys.elementAt(value),
              children: widget.children.values
                  .map(
                    (e) => Center(
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
