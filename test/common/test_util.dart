import 'dart:io';
import 'dart:math';

import 'package:currency_conversion/src/ui/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;

Future<Directory> getHiveTempDir() async {
  final tempPath = path.join(Directory.current.path, '.dart_tool', 'test', 'tmp');
  final random = Random();
  final name = random.nextInt(pow(2, 32) as int);
  final dir = Directory(path.join(tempPath, '${name}_tmp'));

  if (dir.existsSync()) {
    await dir.delete(recursive: true);
  }
  await dir.create(recursive: true);
  return dir;
}

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  addTearDown(container.dispose);

  return container;
}

Widget buildTestWidget({
  required Widget widget,
  List<Override> overrides = const [],
}) =>
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final appLocalizations = AppLocalizations.of(context)!;
            L10n.init(appLocalizations);

            return Material(
              child: widget,
            );
          },
        ),
      ),
    );
