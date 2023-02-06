import 'package:app_game/src/cubits/paintings_cubit.dart';
import 'package:app_game/src/widgets/text_widget.dart';
import 'package:app_game/src/widgets/textspan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaintingDetailsPage extends StatelessWidget {
  const PaintingDetailsPage({super.key, required this.painting});

  static Page page({required Map<String, String> painting}) {
    return MaterialPage<void>(
      child: PaintingDetailsPage(painting: painting),
    );
  }

  final Map<String, String> painting;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PaintingsCubit>(context).deselectPainting();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('images/reduced_appbar.jpg'),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFECB307),
          title: const TextCreator(
            text: 'Met on Canvas',
            textSize: 40,
            isFontBold: true,
            fontColor: 0xFF000000,
            isCenter: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 400,
                ),
                child: Image.network(
                  '${painting['primaryImage']}',
                  width: 300,
                ),
              ),
              Container(
                width: 200,
                height: 40,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('images/details_divider.png'),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextSpanCreator(
                    header: 'Title: ',
                    content: painting['title']!,
                  ),
                  TextSpanCreator(
                    header: 'Artist: ',
                    content: painting['artistDisplayName']!,
                  ),
                  TextSpanCreator(
                    header: 'Medium: ',
                    content: painting['medium']!,
                  ),
                  TextSpanCreator(
                    header: 'Dimensions: ',
                    content: painting['dimensions']!,
                  ),
                  TextSpanCreator(
                    header: 'Estimated Year of Completion: ',
                    content: painting['objectEndDate']!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
