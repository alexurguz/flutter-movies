import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget{
  List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController = new PageController(
          initialPage: 1,
          viewportFraction: 0.35
        );

  @override
  Widget build(BuildContext context){
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        nextPage();
      }
    });

    return Container(
      padding: EdgeInsets.only( top: 10.0 ),
      //width: _screenSize.width * 0.5,
      //height: _screenSize.height * 0.5,
      width: double.infinity,
      height: _screenSize.width * 0.70,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context),
        itemCount: movies.length,
        itemBuilder: ( context, i ){
          return _card(context, movies[i]);
        },
      ),
    );
  }

  Widget _card( BuildContext context, Movie movie ){

    movie.uniqueId = '${movie.id}-poster';

    final card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 190.0
                )
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.caption
            )
          ],
        )
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  List<Widget> _cards(BuildContext context){
    return movies.map( (movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 190.0
              )
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.caption
            )
          ],
        )
      );
    } ).toList();
  }
}


