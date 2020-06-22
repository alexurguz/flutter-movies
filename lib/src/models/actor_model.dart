class Cast {

  List<Actor> actors = new List();

  Cast();

  Cast.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    jsonList.forEach(( row ) {
      final actor = new Actor.fromJsonMap( row );
      actors.add( actor );
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

    Actor.fromJsonMap(Map<String, dynamic> json){
    castId = json['cast_id'];
    character = json['vote_count'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

   getProfileImg(){
    if(profilePath == null){
      return 'https://image.shutterstock.com/image-vector/no-user-profile-picture-hand-600w-99335579.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

