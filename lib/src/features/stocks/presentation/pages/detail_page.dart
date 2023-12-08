import 'package:fitpage_test/src/core/core.dart';
import 'package:fitpage_test/src/features/stocks/presentation/widgets/my_tooltip.dart';
import 'package:fitpage_test/src/features/stocks/stocks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  stockModel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  stockModel.tag,
                  style: TextStyle(
                    color: UIConstants.colorMap[stockModel.color],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: stockModel.criteria.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: stockModel.criteria
                          .map(
                            (e) => _processedText(e),
                          )
                          .toList(),
                    )
                  : const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _processedText(CModel cm) {
    String? text = cm.text;
    if (text != null) {
      if (text.contains('\$')) {
        final variable = cm.variable;
        text = text.replaceAll('\$', '@');
        final regExp = RegExp("@");
        final matches = regExp.allMatches(text);
        List<Widget> childrens = List.empty(growable: true);
        if (variable != null) {
          final v1 = variable.$1;
          final v2 = variable.$2;
          final v3 = variable.$3;
          final v4 = variable.$4;

          final vmap = {
            '@1': v1,
            '@2': v2,
            '@3': v3,
            '@4': v4,
          };

          if (matches.isNotEmpty) {
            String? newString;
            newString = text;
            int lastIdx = 0;
            for (int i = 0; i < matches.length; i++) {
              final idx = newString?.indexOf('@');
              childrens.add(Text(newString?.substring(lastIdx, idx!) ?? ''));

              final val = newString?.substring(idx!, idx + 2);
              final data = vmap[val]?.values != null
                  ? vmap[val]?.values?.first
                  : vmap[val]?.defaulValue;
              final replace = '($data)';
              lastIdx = idx! + replace.length;
              newString =
                  newString?.replaceRange(idx, idx + 2, '(${data ?? 0})');

              childrens.add(MyTooltip(
                  message: vmap[val]?.type == 'indicator'
                      ? '${vmap[val]?.defaulValue}'
                      : vmap[val]
                              ?.values
                              ?.map((e) => '$e')
                              .toList()
                              .join('\n') ??
                          '',
                  child: Text(
                    replace,
                    style: const TextStyle(
                        color: Colors.blue, fontStyle: FontStyle.italic),
                  )));
            }
            childrens.add(Text(newString!.substring(lastIdx)));
            return Wrap(
              children: childrens,
            );
          }
        }
      } else {
        return Text(text);
      }
    }
    //else {
    return const SizedBox.shrink();
    //}
  }
}
