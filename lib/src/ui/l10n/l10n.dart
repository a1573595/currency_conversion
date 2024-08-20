import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class L10n extends LocalizationsDelegate<AppLocalizations> {
  const L10n();

  static late AppLocalizations _current;

  static AppLocalizations get current => _current;

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    L10n(),
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static L10n? of(BuildContext context) => Localizations.of<L10n>(context, L10n);

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    _current = await SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
    return _current;
  }

  @override
  bool shouldReload(L10n old) => false;

  static void init(AppLocalizations appLocalizations) => _current = appLocalizations;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
