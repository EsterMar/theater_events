import 'Teatro.dart';


class Sala {
  int? room_number;
  String? zone;
  int? capacity;
  Teatro? teatro;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Sala({this.room_number, this.zone, this.capacity, this.teatro});

  factory Sala.fromJson(Map<String, dynamic> json) {
    return Sala(
      room_number: json['room_number'],
      zone: json['zone'],
      capacity: json['capacity'],
      teatro: json['teatro']!= null ? Teatro.fromJson(json['teatro']):null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'room_number': room_number,
        'zone': zone,
        'capacity': capacity,
        'teatro': teatro?.toJson(),
      };


  @override
  String toString() {
    return'$room_number ${zone ?? ''}';
  }


}