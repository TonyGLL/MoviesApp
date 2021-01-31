class Cast {
  List<Actor> actors = new List();

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditid;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor(
      {this.castId,
      this.character,
      this.creditid,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath});

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditid = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getActorPhoto() {
    if (profilePath == null) {
      return 'data:image/jpeg;base64,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';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
