part of 'home_view_model.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();

    final pageList = useMemoized(() => const [CurrencyScreen(), ConvertScreen()]);

    ref.listen(pagePositionProvider, (previous, next) {
      controller.jumpToPage(next);
    });

    return TwicePopScope(
      child: Scaffold(
        body: ref
            .watch(currencyListProvider)
            .when(
              data: (data) => SafeArea(
                child: PageView.builder(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pageList.length,
                  itemBuilder: (context, index) => pageList[index],
                ),
              ),
              error: (error, stackTrace) => Center(child: Text(error.toString())),
              loading: () => const LoaderBody(),
            ),
        bottomNavigationBar: const _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends HookConsumerWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: ref.watch(pagePositionProvider),
      onTap: (index) => ref.read(pagePositionProvider.notifier).state = index,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.attach_money, key: AppKeys.currencyTab),
          label: L10n.current.currency,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calculate, key: AppKeys.convertTab),
          label: L10n.current.convert,
        ),
      ],
    );
  }
}
