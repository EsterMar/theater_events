import 'Sala.dart';

class Posto {
  int? id;
  int? seat;
  int? row;
  bool? available;
  int? version;
  Sala? sala;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Posto({this.id, this.seat, this.row, this.available, this.version, this.sala});

  factory Posto.fromJson(Map<String, dynamic> json) {
    return Posto(
      id: json['id'],
      seat: json['seat'],
      row: json['row'],
      available: json['available'],
      version: json['version'],
      sala: json['sala'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'seat': seat,
        'row': row,
        'available': available,
        'version': version,
        'sala': sala,

};
  @override
  String toString() {
    return '${row.toString()} ${seat.toString()}';
  }


}