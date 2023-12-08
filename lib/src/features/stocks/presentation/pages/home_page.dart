import 'package:fitpage_test/src/core/core.dart';
import 'package:fitpage_test/src/features/stocks/domain/domain.dart';
import 'package:fitpage_test/src/features/stocks/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocks = ref.watch(getStocksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitpage'),
        elevation: 2,
      ),
      body: SafeArea(
        child: stocks.when(
          data: (data) {
            return data.fold(
              (l) => Center(
                child: Text(l.message),
              ),
              (r) => Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                  itemCount: r.length,
                  shrinkWrap: true,
                  itemBuilder: (c, i) => ListTile(
                    key: ValueKey(r[i].id),
                    title: Text(r[i].name),
                    subtitle: Text(
                      r[i].tag,
                      style: TextStyle(
                        color: UIConstants.colorMap[r[i].color],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => DetailPage(stockModel: r[i]),
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      index == r.length
                          ? const SizedBox.shrink()
                          : const Divider(
                              height: 1.2,
                            ),
                ),
              ),
            );
          },
          error: (_, __) => const Center(
            child: Text('Some Error occured'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
