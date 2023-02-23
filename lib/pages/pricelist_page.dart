import 'package:flutter/material.dart';
import '../widgets/scaffold_main.dart';

class PriceListPage extends StatelessWidget {
  const PriceListPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: PriceListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      content: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'What would you like to cook?',
          ),
          Text(
            '3',
          ),
          // createSearchBar(),
          // showSearchOptions(),
        ],
      ),
    );
  }
}
