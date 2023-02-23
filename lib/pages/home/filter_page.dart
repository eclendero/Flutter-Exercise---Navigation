import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/home/filter/category_filter_cubit.dart';
import '../../cubits/home/filter/filter_cubit.dart';
import '../../cubits/home/filter/ingredient_filter_cubit.dart';
import '../../cubits/home/filter/pricelimit_filter_cubit copy.dart';
import '../../cubits/page_selection.dart';
import '../../cubits/home/recipe_list_cubit.dart';
import '../../cubits/home/search_details_cubit.dart';
import '../../models/filter_model.dart';

class FilterPage extends StatelessWidget {
  FilterPage({Key? key}) : super(key: key);

  static Page page() {
    return MaterialPage<void>(
      child: FilterPage(),
    );
  }

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  final ingredientFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFED76A),
        body: Column(
          children: [
            createHeadBar(),
            const SizedBox(height: 20),
            showOptions(),
          ],
        ),
      ),
    );
  }

  Widget createHeadBar() {
    return BlocBuilder<RecipeListCubit, List>(builder: (context, recipeList) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              createReturnButton(),
              const Text('Search Filter'),
            ],
          ),
          InkWell(
            onTap: () {
              //Reverts values to initial state
              minPriceController.clear();
              maxPriceController.clear();
              BlocProvider.of<FilterCubit>(context).reset();
              BlocProvider.of<CategoryFilterCubit>(context).reset();
              BlocProvider.of<PriceLimitFilterCubit>(context).reset();
              BlocProvider.of<IngredientFilterCubit>(context).reset();
            },
            child: const Text('Reset'),
          ),
        ],
      );
    });
  }

  Widget createReturnButton() {
    return BlocBuilder<CategoryFilterCubit, List>(
        builder: (context, categories) {
      return BlocBuilder<PriceLimitFilterCubit, String>(
          builder: (context, priceLimit) {
        return BlocBuilder<IngredientFilterCubit, List>(
            builder: (context, ingredients) {
          return InkWell(
            onTap: () {
              var filters = Filters(
                ingredients: ingredients,
                categories: categories,
                priceLimit: priceLimit,
              );
              var fin = filters.toMap();
              for (var item in fin.keys) {
                BlocProvider.of<SearchDetailsCubit>(context)
                    .storeSearchDetails({item: fin[item]});
              }
              BlocProvider.of<PageSelectionCubit>(context).selectPage(0);
            },
            child: const Icon(Icons.arrow_back_ios),
          );
        });
      });
    });
  }

  Widget showOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addIngredient(),
        const SizedBox(height: 20),
        addCategory(),
        const SizedBox(height: 20),
        addPriceLimit(),
      ],
    );
  }

  Widget addIngredient() {
    return BlocBuilder<IngredientFilterCubit, List>(builder: (context, list) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ingredient'),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(5),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: ingredientFieldController,
                            onEditingComplete: () {
                              BlocProvider.of<IngredientFilterCubit>(context)
                                  .addItem(ingredientFieldController.text);
                              ingredientFieldController.clear();
                              Navigator.pop(context);
                              // BlocProvider.of<FilterCubit>(context)
                              //     .store({'ingredients': list});
                            },
                            //Allows the errorText to be updated
                            // onFieldSubmitted: (newText) =>
                            //     BlocProvider.of<AmountValidationCubit>(context)
                            //         .validateAmount(newText),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(42, 104, 111, 0.25),
                              hintText: 'Minimum',
                              hintStyle: TextStyle(
                                  fontSize: 18, color: Color(0xFF406374)),
                              border: InputBorder
                                  .none, //Removes the default bottom border
                              //Creates a bottom border when field is clicked
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(42, 104, 111, 1),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            style: (const TextStyle(
                                fontSize: 18, color: Color(0xFFFFFFFF))),
                          ),
                        );
                      });
                },
                // BlocProvider.of<PageSelectionCubit>(context).selectPage(0),
                child: const Icon(Icons.add_rounded),
              )
            ],
          ),
          Wrap(
            spacing: 20,
            runSpacing: 5,
            children: list
                .map(
                  (item) => Chip(
                    label: Text(item),
                    onDeleted: () {
                      // print(item);
                      BlocProvider.of<IngredientFilterCubit>(context)
                          .removeItem(item);
                    },
                    deleteIcon: const Icon(Icons.cancel),
                  ),
                )
                .toList(),
          ),
        ],
      );
    });
  }

  Widget addCategory() {
    List categories = ['Entrees', 'Sides', 'Appetizers'];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Category'),
      Wrap(
        direction: Axis.horizontal,
        spacing: 20,
        children: [
          for (var item in categories) createCategory(item),
        ],
      )
    ]);
  }

  createCategory(String item) {
    return BlocBuilder<CategoryFilterCubit, List>(
        builder: (context, selectedItems) {
      return GestureDetector(
        onTap: () {
          if (!selectedItems.contains(item)) {
            BlocProvider.of<CategoryFilterCubit>(context).selectItem(item);
          } else {
            BlocProvider.of<CategoryFilterCubit>(context).deselectItem(item);
          }
        },
        child: Chip(
          label: Text(
            item,
            style: TextStyle(
                color:
                    selectedItems.contains(item) ? Colors.black : Colors.grey),
          ),
        ),
      );
    });
  }

  createPrice(String item) {
    return BlocBuilder<PriceLimitFilterCubit, String>(
        builder: (context, selectedItem) {
      return GestureDetector(
        onTap: () {
          if (selectedItem != item) {
            minPriceController.clear();
            maxPriceController.clear();
            BlocProvider.of<PriceLimitFilterCubit>(context).selectItem(item);
          } else {
            BlocProvider.of<PriceLimitFilterCubit>(context).reset();
          }
        },
        child: Chip(
          label: Text(
            item,
            style: TextStyle(
                color: (selectedItem == item) ? Colors.black : Colors.grey),
          ),
        ),
      );
    });
  }

  Widget addPriceLimit() {
    List pricePresets = ['<200', '<500', '<1000'];
    return BlocBuilder<PriceLimitFilterCubit, String>(
        builder: (context, selectedItem) {
      return Column(children: [
        const Text('Price Limit'),
        TextFormField(
          controller: minPriceController,
          onEditingComplete: () {
            BlocProvider.of<PriceLimitFilterCubit>(context).reset();
            BlocProvider.of<PriceLimitFilterCubit>(context)
                .selectItem('< ${minPriceController.text}');
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // maxLength: 50,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(42, 104, 111, 0.25),
            hintText: 'Maximum',
            hintStyle: TextStyle(fontSize: 18, color: Color(0xFF406374)),
            border: InputBorder.none, //Removes the default bottom border
            //Creates a bottom border when field is clicked
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(42, 104, 111, 1),
                width: 1.5,
              ),
            ),
          ),
          style: (const TextStyle(fontSize: 18, color: Color(0xFFFFFFFF))),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: [
            for (var item in pricePresets) createPrice(item),
          ],
        ),
      ]);
    });
  }
}
