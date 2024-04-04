class Spettacolo {
  int? id;
  String? title;
  String? genre;
  String? description;
  DateTime? first_day;
  DateTime? last_day;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Spettacolo({this.id, this.title, this.genre, this.description, this.first_day, this.last_day});

  factory Spettacolo.fromJson(Map<String, dynamic> json) {
    return Spettacolo(
      id: json['id'],
      title: json['title'],
      genre: json['genre'],
      description: json['description'],
      first_day: json['first_day'],
      last_day: json['last_day'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'genre': genre,
        'description': description,
        'first_day': first_day,
        'last_day': last_day,

      };
  @override
  String toString() {
    return '$title';
  }


}