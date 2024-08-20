part of 'home_view_model.dart';

class CurrencyScreen extends ConsumerWidget {
  const CurrencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ref.watch(currencyListProvider).when(
            data: (data) => _CurrencyBody(data),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const LoaderBody(),
          ),
    );
  }
}

class _CurrencyBody extends StatelessWidget {
  const _CurrencyBody(this.list, {super.key});

  final List<Currency> list;

  @override
  Widget build(BuildContext context) {
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
            itemBuilder: (context, index) => _CurrencyItem(list[index]),
          ),
        ),
      ],
    );
  }
}

class _CurrencyTitle extends StatelessWidget {
  const _CurrencyTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: ,
      // leading: const SizedBox(
      //   width: WidgetStyle.p32,
      // ),
      title: Row(
        children: [
          Text(
            L10n.current.currency,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          Text(
            L10n.current.price,
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
      leading: CachedNetworkImage(
        height: WidgetStyle.p32,
        width: WidgetStyle.p32,
        imageUrl: currency.flagImage,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.fitWidth,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${currency.code} / TWD",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            thousandsSeparatorFormat.format(currency.twdPrice),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
