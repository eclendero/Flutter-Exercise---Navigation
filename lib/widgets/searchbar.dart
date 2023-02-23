import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/home/filter/category_filter_cubit.dart';
import '../cubits/home/filter/filter_cubit.dart';
import '../cubits/home/filter/ingredient_filter_cubit.dart';
import '../cubits/home/filter/pricelimit_filter_cubit copy.dart';
import '../cubits/home/results_header_cubit.dart';
import '../cubits/home/search_details_cubit.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultsHeaderCubit, Map>(builder: (context, tags) {
      return BlocBuilder<SearchDetailsCubit, Map>(builder: (context, details) {
        return TextFormField(
          controller: searchController,
          onEditingComplete: () {
            BlocProvider.of<SearchDetailsCubit>(context)
                .storeSearchDetails({'title': searchController.text});
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: InkWell(
              onTap: () {
                // BlocProvider.of<SearchDetailsCubit>(context)
                //     .storeSearchDetails({'title': searchController.text});
                print(details);
                //Store the search details for rendering of search tags
                //Even if new search details is being inputted, the previous search tags
                //is still rendered until the search icon is clicked
                BlocProvider.of<ResultsHeaderCubit>(context).storeTags(details);
                //Reset the search and filter fields except for the scope
                BlocProvider.of<SearchDetailsCubit>(context).reset();
                BlocProvider.of<FilterCubit>(context).reset();
                BlocProvider.of<CategoryFilterCubit>(context).reset();
                BlocProvider.of<PriceLimitFilterCubit>(context).reset();
                BlocProvider.of<IngredientFilterCubit>(context).reset();
                searchController.clear();
                // if (details.isNotEmpty || (details.isEmpty && isVisible)) {
                //   BlocProvider.of<ResultsHeaderCubit>(context)
                //       .changeVisibility();
                // }
              },
              child: const Icon(Icons.search),
            ),
            // filled: true,
            // fillColor: const Color.fromRGBO(42, 104, 111, 0.25),
            hintText: 'Search Recipes',
            hintStyle: const TextStyle(fontSize: 18, color: Color(0xFF406374)),
            // border: InputBorder.none, //Removes the default bottom border
            //Creates a bottom border when field is clicked
          ),
          style: (const TextStyle(fontSize: 18, color: Color(0xFF406374))),
        );
      });
    });
  }
}
