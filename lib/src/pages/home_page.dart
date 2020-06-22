import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget{

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context){
    moviesProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar (
        centerTitle: false,
        title: Text('Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ), 
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch()
              );
            }),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards(),
            SizedBox( height: 5.0 ),
            _seePopularMovies(context),
          ],
        )
      ),
    );
  }

  Widget _swiperCards(){

    return FutureBuilder(
      future: moviesProvider.getMoviesNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(
            movies: snapshot.data,
          );
        }else{
          return Container(
            height: 400.0,
            child: Center (
              child: CircularProgressIndicator(),
            )
          );
        }
      }
    );
  }

  Widget _seePopularMovies(BuildContext context){
    return Container(
            width: double.infinity,
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Popular', style: Theme.of(context).textTheme.subtitle1,)
                ),
                SizedBox( height: 5.0 ),
                StreamBuilder(
                  stream: moviesProvider.popularStream,
                  builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                   if(snapshot.hasData){
                      return MovieHorizontal(
                        movies: snapshot.data,
                        nextPage: moviesProvider.getPopularMovies,
                      );
                    }else{
                      return Center( child: CircularProgressIndicator() );
                    }
                  }
                ),
              ],
            ),
          );
  }
}