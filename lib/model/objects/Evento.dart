import 'Posto.dart';
import 'Spettacolo.dart';
import 'Sala.dart';

class Evento {
  int? id;
  String? hours;
  DateTime? data;
  Posto? posto;
  Sala? sala;
  Spettacolo? spettacolo;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Evento({this.id, this.hours, this.data, this.posto, this.sala, this.spettacolo});

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'],
      hours: json['hours'],
      data: json['data'],
      posto: json['posto'],
      sala: json['sala'],
      spettacolo: json['spettacolo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'hours': hours,
    'data': data,
    'posto': posto,
    'sala': sala,
    'spettacolo': spettacolo,
  };

  @override
  String toString() {
    return '${spettacolo?.title} ${data.toString()} $hours';
  }


}