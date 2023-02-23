import 'package:app_game/cubits/page_selection.dart';
import 'package:app_game/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/creations_page.dart';
import 'pages/home/filter_page.dart';
import 'pages/pricelist_page.dart';
import 'pages/recipe_details_page.dart';
import 'states/page_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Page> onGeneratePages(PageSelectionState state, List<Page> pages) {
    final selectedPage = state.selectedPage;
    //Generate the PaintingList and PaintingDetails Pages
    return [
      if (selectedPage == 1)
        CreationsPage.page()
      else if (selectedPage == 2)
        PriceListPage.page()
      else if (selectedPage == 3)
        FilterPage.page()
      else if (selectedPage == 4)
        RecipeDetailsPage.page()
      else
        HomePage.page()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FlowBuilder(
          state: context.watch<PageSelectionCubit>().state,
          onGeneratePages: onGeneratePages,
        ),
      );
    });
  }
}
