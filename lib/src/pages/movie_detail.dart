import 'package:flutter/material.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/actors_provider.dart';

class MovieDetail extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0 ),
                _seePosterTitle( context, movie ),
                _seeDescription( movie ),
                _seeCast( movie ),
              ]
            ),
          )
        ]
      ),
    );
  }

  Widget _createAppBar(Movie movie){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle( color: Colors.white, fontSize: 16.0 ),
        ),
        background: FadeInImage( 
            image: NetworkImage( movie.getBackgroundImg() ), 
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration( milliseconds: 150 ),
            fit: BoxFit.cover,
          ),
      ),
    );
  }

  Widget _seePosterTitle(BuildContext context, Movie movie){
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 20.0 ),
              child: Image(
                image: NetworkImage( movie.getPosterImg() ),
                height: 150.0,
              )
            ),
          ),
          SizedBox( width: 20.0 ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( movie.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.clip ),
                Text( movie.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis ),
                  ],
                )
              ],
            )
          ),
        ],
      )
    );
  }

  Widget _seeDescription(Movie movie){
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 10.0 ),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),

    );
  }

  Widget _seeCast(Movie movie){

    final actorProvider = new ActorsProvider();

    return FutureBuilder(
      future: actorProvider.getCastMovie( movie.id.toString() ),
      builder: ( BuildContext context, AsyncSnapshot<List> snapshot ){
        if( snapshot.hasData ){
          return _createActorsPageView( snapshot.data );
        }else{
          return Center( child: CircularProgressIndicator(), );
        }
      }
    );
  }

  Widget _createActorsPageView( List<Actor> actors){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.4,
          initialPage: 1
        ),
        itemCount: actors.length,
        itemBuilder: ( context, i ) => _actorCard( actors[i] ),
      ),
    );
  }

  Widget _actorCard( Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular( 20.0 ),
            child: FadeInImage(
              image: NetworkImage( actor.getProfileImg() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fadeInDuration: Duration( milliseconds: 150 ),
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}