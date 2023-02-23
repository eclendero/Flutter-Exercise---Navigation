import 'package:app_game/cubits/home/search_options_cubit.dart';
import 'package:app_game/widgets/scaffold_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/page_selection.dart';
import '../../cubits/home/recipe_list_cubit.dart';
import '../../cubits/home/results_header_cubit.dart';
import '../../widgets/searchbar.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsHeaderCubit, Map>(builder: (context, searchTags) {
      return MainScaffold(
        content: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'What would you like to cook?',
            ),
            SearchBar(),
            displaySearchOptions(),
            searchTags.isNotEmpty
                ? createResultsHeader(searchTags)
                : Container(),
            Expanded(
              child: showRecipes(),
            ),
          ],
        ),
      );
    });
  }

  Widget createResultsHeader(Map searchTags) {
    List tags = [];
    //Create a list from the map of search details
    //Exclude scope and title from the list
    for (var item in searchTags.keys) {
      if (item != 'scope' && item != 'title') {
        //Iterate through ingredients and categories since they are lists
        if (item == 'ingredients' || item == 'categories') {
          for (var object in searchTags[item]) {
            tags.add(object);
          }
        } else {
          tags.add(searchTags[item]);
        }
      }
    }
    return BlocBuilder<ResultsHeaderCubit, Map>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Results Found: '),
          SizedBox(
            height: 30,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            BlocProvider.of<ResultsHeaderCubit>(context)
                                .resetTags();
                          },
                          child: Text('Clear Tags'),
                        ),
                        //Show the title of recipe inputted at the start if a title is included in search
                        searchTags.containsKey('title')
                            ? Chip(
                                label: Text(
                                  searchTags['title']!,
                                ),
                              )
                            : Container(),
                        for (var item in tags)
                          Chip(
                            label: Text(
                              item,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget displaySearchOptions() {
    return BlocBuilder<SearchOptionCubit, int>(builder: (context, option) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              createOptionText('All', 1),
              const SizedBox(width: 20),
              createOptionText('Suggested', 2),
              const SizedBox(width: 20),
              createOptionText('My Recipes', 3),
            ],
          ),
          //Filter
          InkWell(
            onTap: () =>
                BlocProvider.of<PageSelectionCubit>(context).selectPage(3),
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/filter.png'),
                    ),
                  ),
                ),
                // const SizedBox(width: 5),
                const Text('Filter'),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget createOptionText(String content, int option) {
    return BlocBuilder<SearchOptionCubit, int>(builder: (context, state) {
      return InkWell(
        onTap: () {
          //Change font color of the clicked option
          BlocProvider.of<SearchOptionCubit>(context).selectOption(option);
          late String scope;
          if (option == 2) {
            scope = 'Suggested';
          } else if (option == 3) {
            scope = 'My Recipes';
          } else {
            scope = 'All';
          }
          //Store option for search
          // BlocProvider.of<SearchDetailsCubit>(context)
          //     .storeSearchDetails({'scope': scope});
          //If newly pressed, automatically do a search
        },
        child: Text(
          content,
          style: TextStyle(
            color: (state == option)
                ? const Color(0xFFE8B022)
                : const Color(0xFFBFBFBF),
          ),
        ),
      );
    });
  }

  Widget showRecipes() {
    return BlocBuilder<RecipeListCubit, List>(builder: (context, recipeList) {
      return ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (context, index) {
          //Create Map
          return Column(
            children: [
              const SizedBox(height: 5),
              createEntry(index),
            ],
          );
        },
      );
    });
  }

  Widget createEntry(int index) {
    return BlocBuilder<RecipeListCubit, List>(builder: (context, recipeList) {
      return InkWell(
        onTap: () {
          BlocProvider.of<PageSelectionCubit>(context).selectPage(4);
        },
        child: Container(
          height: 50,
          // margin: const EdgeInsets.only(left: 15),
          padding: const EdgeInsets.all(3.0),
          decoration: const BoxDecoration(
            color: Color(0xFFFFF0C1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // shape: BoxShape.circle,
          ),
        ),
      );
    });
  }
}
