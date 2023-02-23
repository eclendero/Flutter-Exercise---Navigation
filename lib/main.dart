import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'cubits/home/filter/category_filter_cubit.dart';
import 'cubits/home/filter/filter_cubit.dart';
import 'cubits/home/filter/ingredient_filter_cubit.dart';
import 'cubits/home/filter/pricelimit_filter_cubit copy.dart';
import 'cubits/page_selection.dart';
import 'cubits/home/recipe_list_cubit.dart';
import 'cubits/home/results_header_cubit.dart';
import 'cubits/home/search_details_cubit.dart';
import 'cubits/home/search_options_cubit.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter(); //Initialize hive for graphql queries
  runApp(const Providers());
}

class Providers extends StatelessWidget {
  const Providers({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageSelectionCubit()),
        BlocProvider(create: (_) => SearchDetailsCubit()),
        BlocProvider(create: (_) => SearchOptionCubit()),
        BlocProvider(create: (_) => RecipeListCubit()..fetchRecipes()),
        BlocProvider(create: (_) => IngredientFilterCubit()),
        BlocProvider(create: (_) => CategoryFilterCubit()),
        BlocProvider(create: (_) => PriceLimitFilterCubit()),
        BlocProvider(create: (_) => FilterCubit()),
        BlocProvider(create: (_) => ResultsHeaderCubit()),
        // BlocProvider(
        //     create: (_) => FilterCubit(
        //           ingredients: context.read<IngredientFilterCubit>(),
        //           priceLimit: context.read<PriceLimitFilterCubit>(),
        //           categories: context.read<CategoryFilterCubit>(),
        //         )),
        //On start-up, immediately call the fetchList()
        // BlocProvider(create: (_) => PostCubit()..fetchList()),
      ],
      child: const MyApp(),
    );
  }
}
