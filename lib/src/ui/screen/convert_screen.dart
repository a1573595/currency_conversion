part of 'home_view_model.dart';

class ConvertScreen extends ConsumerWidget {
  const ConvertScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: WidgetStyle.p16,
        top: WidgetStyle.p16,
        right: WidgetStyle.p16,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              L10n.current.amount,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: WidgetStyle.p8,
          ),
          const _AmountTextField(),
          const SizedBox(
            height: WidgetStyle.p32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.current.from,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return _CurrencyCard(
                          currency: ref.watch(convertUiStateProvider).fromCurrency,
                          onChanged: ref.read(convertUiStateProvider.notifier).updateFromCurrency,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    onPressed: ref.read(convertUiStateProvider.notifier).switchCurrency,
                    icon: const Icon(
                      Icons.change_circle,
                      size: 64,
                    ),
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.current.to,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return _CurrencyCard(
                          currency: ref.watch(convertUiStateProvider).toCurrency,
                          onChanged: ref.read(convertUiStateProvider.notifier).updateToCurrency,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: WidgetStyle.p32,
          ),
          const _RateText(),
          const SizedBox(
            height: WidgetStyle.p64,
          ),
          const _FromCurrencyText(),
          const SizedBox(
            height: WidgetStyle.p16,
          ),
          Text(
            "≈",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: WidgetStyle.p16,
          ),
          const _ResultText(),
        ],
      ),
    );
  }
}

class _AmountTextField extends HookConsumerWidget {
  const _AmountTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: ref.read(convertUiStateProvider).amountText);

    return TextFormField(
      controller: controller,
      textAlign: TextAlign.end,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: ref.read(convertUiStateProvider.notifier).updateAmountText,
    );
  }
}

class _CurrencyCard extends HookConsumerWidget {
  const _CurrencyCard({
    super.key,
    required this.currency,
    required this.onChanged,
  });

  final Currency currency;
  final Function(Currency) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = useMemoized(() => {for (final i in ref.read(currencyListProvider).requireValue) i: i.code});

    final onTap = useCallback(
        () => showPickerSheet(context, children: children, initialValue: currency).then((value) {
              if (value != null) {
                onChanged(value);
              }
            }),
        [currency]);

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(WidgetStyle.p8),
          child: Row(
            children: [
              CachedNetworkImage(
                height: Theme.of(context).textTheme.headlineMedium!.fontSize,
                width: Theme.of(context).textTheme.headlineMedium!.fontSize,
                imageUrl: currency.flagImage,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                currency.code,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RateText extends ConsumerWidget {
  const _RateText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromCurrency = ref.watch(convertUiStateProvider.select((value) => value.fromCurrency));
    final toCurrency = ref.watch(convertUiStateProvider.select((value) => value.toCurrency));
    final rateText = ref.watch(convertUiStateProvider.select((value) => value.rateText));

    return Text(
      "1 ${fromCurrency.code} ≈ $rateText ${toCurrency.code}",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _FromCurrencyText extends ConsumerWidget {
  const _FromCurrencyText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountText = ref.watch(convertUiStateProvider.select((value) => value.amountText));
    final fromCurrency = ref.watch(convertUiStateProvider.select((value) => value.fromCurrency));

    return Text(
      "$amountText ${fromCurrency.code}",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _ResultText extends ConsumerWidget {
  const _ResultText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultText = ref.watch(convertUiStateProvider.select((value) => value.resultText));
    final toCurrency = ref.watch(convertUiStateProvider.select((value) => value.toCurrency));

    return Text(
      "$resultText ${toCurrency.code}",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
