import 'package:app_game/widgets/scaffold_main.dart';
import 'package:flutter/material.dart';

class CreationsPage extends StatelessWidget {
  const CreationsPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: CreationsPage(),
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
            '2',
          ),
          // createSearchBar(),
          // showSearchOptions(),
        ],
      ),
    );
  }
}
