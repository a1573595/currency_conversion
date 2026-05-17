import 'package:currency_conversion/common/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TwicePopScope extends StatefulWidget {
  const TwicePopScope({super.key, required this.child, this.now});

  final Widget child;
  final DateTime Function()? now;

  @override
  State<TwicePopScope> createState() => _TwicePopScopeState();
}

class _TwicePopScopeState extends State<TwicePopScope> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (_popBack(context)) {
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }

  bool _popBack(BuildContext context) {
    final now = widget.now?.call() ?? DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(L10n.current.pressAgainToExit)));

      return false;
    }
    return true;
  }
}
