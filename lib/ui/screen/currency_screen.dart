part of 'home_view_model.dart';

class CurrencyScreen extends ConsumerWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(currencyListProvider).requireValue;

    return Column(
      children: [
        const _CurrencyTitle(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: WidgetStyle.p16,
              right: WidgetStyle.p16,
              bottom: kBottomNavigationBarHeight,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) => _CurrencyItem(key: ValueKey(list[index].code), list[index]),
          ),
        ),
      ],
    );
  }
}

class _CurrencyTitle extends StatelessWidget {
  const _CurrencyTitle();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(width: WidgetStyle.p32),
      title: Row(
        children: [
          Text(L10n.current.currency, style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          Text(L10n.current.price, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _CurrencyItem extends StatelessWidget {
  const _CurrencyItem(this.currency, {super.key});

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: _CurrencyFlagImage(currency: currency, size: WidgetStyle.p32),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("${currency.code} / TWD", style: Theme.of(context).textTheme.bodyMedium),
          Text(thousandsSeparatorFormat.format(currency.twdPrice), style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _CurrencyFlagImage extends StatelessWidget {
  const _CurrencyFlagImage({required this.currency, required this.size});

  final Currency currency;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (currency.flagImage.isEmpty) {
      return SizedBox(height: size, width: size, child: const Icon(Icons.flag_outlined));
    }

    return CachedNetworkImage(
      height: size,
      width: size,
      imageUrl: currency.flagImage,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.fitWidth,
    );
  }
}
