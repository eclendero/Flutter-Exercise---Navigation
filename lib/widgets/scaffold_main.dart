import 'package:app_game/cubits/page_selection.dart';
import 'package:app_game/states/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageSelectionCubit, PageSelectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'foodprints',
              style: TextStyle(
                color: Color(0xFF7F6000),
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: content,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFFFED76A),
            currentIndex: state.selectedPage,
            unselectedItemColor: const Color(0xFFD6A300),
            selectedItemColor: const Color(0xFF393C41),
            onTap: BlocProvider.of<PageSelectionCubit>(context).selectPage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Creations',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Price List',
              ),
            ],
          ),
        );
      },
    );
  }
}
