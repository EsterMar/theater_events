import 'Spettacolo.dart';


class Teatro {
  int? id;
  String? name;
  String? city;
  String? address;
  String? telephone_number;
  Spettacolo? spettacolo;

  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Teatro({this.id, this.name, this.city, this.address, this.telephone_number,this.spettacolo});

  factory Teatro.fromJson(Map<String, dynamic> json) {
    return Teatro(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      telephone_number: json['telephone_number'],
      spettacolo: json['spettacolo'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'city': city,
        'address': address,
        'telephone_number':telephone_number,
        'spettacolo':spettacolo,
      };


  @override
  String toString() {
    return'$name $city';
  }


}