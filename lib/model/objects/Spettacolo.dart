import 'Teatro.dart';

class Spettacolo {
  int? id;
  String? title;
  String? genre;
  String? description;
  double? price;
  DateTime? first_day;
  DateTime? last_day;
  Teatro? teatro;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Spettacolo({this.id, this.title, this.genre, this.description, this.price, this.first_day, this.last_day, this.teatro});

  factory Spettacolo.fromJson(Map<String, dynamic> json) {
    return Spettacolo(
      id: json['id'],
      title: json['title'],
      genre: json['genre'],
      description: json['description'],
      price: json['price'],
      first_day: json['first_day'] != null ? DateTime.fromMillisecondsSinceEpoch(json['first_day']) : null,
      last_day: json['last_day'] != null ? DateTime.fromMillisecondsSinceEpoch(json['last_day']) : null,
      teatro: json['teatro'] != null ? Teatro.fromJson(json['teatro']) : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'genre': genre,
        'description': description,
        'price': price,
        'first_day': first_day?.millisecondsSinceEpoch,
        'last_day': last_day?.millisecondsSinceEpoch,
        'teatro': teatro?.toJson(),
      };

  @override
  String toString() {
    return '$title';
  }


}