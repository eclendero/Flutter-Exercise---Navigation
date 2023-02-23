import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/page_selection.dart';

class RecipeDetailsPage extends StatelessWidget {
  const RecipeDetailsPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: RecipeDetailsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFED76A),
        body: Center(
          child: InkWell(
            onTap: () =>
                BlocProvider.of<PageSelectionCubit>(context).selectPage(0),
            child: const Text('Back to Main'),
          ),
        ),
      ),
    );
  }
}
