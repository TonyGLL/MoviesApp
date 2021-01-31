import 'package:flutter/material.dart';

/* EXTERNAL PACKAGES */
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_07/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        child: Swiper(
      itemWidth: _screenSize.width * 0.7,
      itemHeight: _screenSize.height * 0.5,
      layout: SwiperLayout.STACK,
      itemBuilder: (BuildContext context, int index) {
        movies[index].uniqueId = '${movies[index].id}-card';
        return Hero(
          tag: movies[index].uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: movies[index]),
              child: FadeInImage(
                image: NetworkImage(movies[index].getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      itemCount: movies.length,
    ));
  }
}
