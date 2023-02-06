import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/cubits/paintings_cubit.dart';
import 'src/cubits/post_cubit.dart';
import 'src/cubits/selection_state.dart';
import 'src/pages/painting_list.dart';
import 'src/pages/painting_details.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PaintingsCubit()),
        BlocProvider(create: (_) => PostCubit()..fetchList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Page> onGeneratePages(SelectionState state, List<Page> pages) {
    final selectedEntry = state.selectedEntry;
    return [
      PaintingListPage.page(paintings: []),
      if (selectedEntry != null)
        PaintingDetailsPage.page(painting: selectedEntry)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MaterialApp(
        title: 'Met on Canvas',
        debugShowCheckedModeBanner: false,
        home: FlowBuilder(
          state: context.watch<PaintingsCubit>().state,
          onGeneratePages: onGeneratePages,
        ),
      );
    });
  }
}
