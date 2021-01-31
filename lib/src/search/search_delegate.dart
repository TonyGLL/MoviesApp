import 'package:flutter/material.dart';
import 'package:peliculas_07/src/models/movie_model.dart';

// FILES
import 'package:peliculas_07/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final moviesProvider = new MoviesProvider();
  final movies = [
    'Spiderman',
    'Spiderman 2',
    'Spiderman 3',
    'Amazing Spiderman',
    'Amazing Spiderman 2',
    'Amazing Spiderman 3',
    'Aquaman',
    'Batman',
    'Shazam',
    'Ironman',
    'Ironman 2',
    'Ironman 2',
    'Ironman 4',
    'Ironman 5',
    'Captain America',
    'Captain America 2',
    'Captain America: Thw Winter Soldier',
    'Avengers EndGame',
    'Avengers Civil War'
  ];
  final newMovies = ['Spiderman', 'Captain America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions of our AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon at the left of AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the results to show
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions when the user wrote something
    // final suggestList = (query.isEmpty)
    //     ? newMovies
    //     : movies
    //         .where(
    //             (movie) => movie.toLowerCase().startsWith(query.toLowerCase()))
    //         .toList();

    // return ListView.builder(
    //   itemCount: suggestList.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(suggestList[i]),
    //       onTap: () {
    //         selection = suggestList[i];
    //         showResults(context);
    //       },
    //     );
    //   },
    // );

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((m) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(m.getPosterImg()),
                width: 50.0,
                fit: BoxFit.cover,
              ),
              title: Text(m.title),
              subtitle: Text(m.releaseDate),
              onTap: () {
                close(context, null);
                m.uniqueId = '';
                Navigator.pushNamed(context, 'details', arguments: m);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
