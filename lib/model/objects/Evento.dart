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

  Evento({this.id, this.hours, this.data, this.posto, this.sala, this.spettacolo});

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      id: json['id'],
      hours: json['hours'],
      data: json['data'] != null ? DateTime.fromMillisecondsSinceEpoch(json['data']) : null,
      posto: json['posto'] != null ? Posto.fromJson(json['posto']) : null,
      sala: json['sala'] != null ? Sala.fromJson(json['sala']) : null,
      spettacolo: json['spettacolo'] != null ? Spettacolo.fromJson(json['spettacolo']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'hours': hours,
    'data': data?.millisecondsSinceEpoch,
    'posto': posto?.toJson(),
    'sala': sala?.toJson(),
    'spettacolo': spettacolo?.toJson(),
  };



  @override
  String toString() {
    return '${data.toString()} $hours ${sala.toString()}';
  }
}
