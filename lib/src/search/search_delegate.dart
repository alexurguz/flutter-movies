import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/models/movie_model.dart';


class DataSearch extends SearchDelegate {

  String seleccion = '';
  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if ( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

          if( snapshot.hasData ) {

            final movies = snapshot.data;

            return ListView(
              children: movies.map( (movie) {
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage( movie.getPosterImg() ),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text( movie.title ),
                    subtitle: Text( movie.originalTitle ),
                    onTap: (){
                      close( context, null);
                      movie.uniqueId = '';
                      Navigator.pushNamed(context, 'detail', arguments: movie);
                      //seleccion = movie.originalTitle;
                      //showResults(context);
                    },
                  );
              }).toList()
            );

          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      },
    );


  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando la persona escribe

  //   final listaSugerida = ( query.isEmpty ) 
  //                           ? peliculasRecientes
  //                           : peliculas.where( 
  //                             (p)=> p.toLowerCase().startsWith(query.toLowerCase()) 
  //                           ).toList();


  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: (){
  //           seleccion = listaSugerida[i];
  //           showResults( context );
  //         },
  //       );
  //     },
  //   );
  // }

}

