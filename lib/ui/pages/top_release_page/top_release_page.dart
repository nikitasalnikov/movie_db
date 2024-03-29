import 'package:flutter/material.dart';
import 'package:movie_db/domain/provider/movie_provder.dart';
import 'package:provider/provider.dart';

class TopReleasePage extends StatelessWidget {
  const TopReleasePage({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF000000),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const GridViewWidget(),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: model.popularFilms?.results?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 280,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onDoubleTap: () {
              model.setFavouritePopular(context, index);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${model.backgroundPath}${model.popularFilms?.results?[index].posterPath}',
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red,
                      ),
                      child: Text(
                        '${model.popularFilms?.results?[index].voteAverage}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
