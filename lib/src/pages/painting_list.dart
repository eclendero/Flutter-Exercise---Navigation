import 'package:app_game/src/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/paintings_cubit.dart';
import '../cubits/post_cubit.dart';

class PaintingListPage extends StatelessWidget {
  const PaintingListPage({Key? key, required this.paintings}) : super(key: key);

  static Page page({required List<Map<String, String>> paintings}) {
    return MaterialPage<void>(
      child: PaintingListPage(paintings: paintings),
    );
  }

  final List<Map<String, String>> paintings;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            displayHeader(),
            displayList(),
          ],
        ),
      ),
    );
  }

  Widget displayHeader() {
    return SliverAppBar(
      backgroundColor: const Color(0xFFECB307),
      expandedHeight: 150,
      collapsedHeight: 75,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const TextCreator(
          text: 'Met on Canvas',
          textSize: 35,
          isFontBold: true,
          fontColor: 0xFF000000,
          isCenter: true,
        ),
        background: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('images/fullsize_appbar.jpg'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color(0xFFD8B25B),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextCreator(
                      text: 'Exploring The Met Paintings',
                      textSize: 20,
                      isFontBold: false,
                      fontColor: 0xFF000000,
                      isCenter: true),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    height: 10,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('images/details_divider.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(String url) async {
    await Future.delayed(const Duration(seconds: 1));
    return url;
  }

  Widget displayList() {
    return BlocBuilder<PostCubit, List>(builder: (context, paintingList) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            //Determine the specific paintng being rendered
            Map<String, String> painting = paintingList[index];
            return GestureDetector(
              onTap: () => BlocProvider.of<PaintingsCubit>(context)
                  .selectPainting(painting),
              child: Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFFD8B25B),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10),
                          FutureBuilder(
                              future: getImage('${painting['primaryImage']}'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  String url = snapshot.data;
                                  return Image.network(
                                    url,
                                    width: 150,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFD8B25B),
                                      strokeWidth: 5,
                                    ),
                                  );
                                }
                              }),
                          const SizedBox(height: 10),
                          TextCreator(
                            text: painting['title']!,
                            textSize: 16,
                            isFontBold: true,
                            fontColor: 0xFF000000,
                            isCenter: true,
                          ),
                          TextCreator(
                            text: painting['artistDisplayName']!,
                            textSize: 16,
                            isFontBold: false,
                            fontColor: 0xFF000000,
                            isCenter: true,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: paintingList.length,
        ),
      );
    });
  }
}
