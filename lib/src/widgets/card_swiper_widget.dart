import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget{
  List<Movie> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context){
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only( top: 10.0 ),
      //width: _screenSize.width * 0.5,
      //height: _screenSize.height * 0.5,
      width: double.infinity,
      height: _screenSize.width * 0.75,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.width,
        itemBuilder: (BuildContext context,int index){

          movies[index].uniqueId = '${movies[index].id}-card';

          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: ()=> Navigator.pushNamed(context, 'detail', arguments: movies[index]),
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              )
            ),
          );
        },
        itemCount: movies.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }

}


