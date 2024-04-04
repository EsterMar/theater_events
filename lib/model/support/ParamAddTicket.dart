import '../objects/Cliente.dart';
import '../objects/Evento.dart';

class ParamAddTicket {
  int? postoId;
  Evento? evento;
  Cliente? cliente;
  double? ticketPrice;



  ParamAddTicket({this.postoId, this.evento, this.cliente, this.ticketPrice});

  factory ParamAddTicket.fromJson(Map<String, dynamic> json) {
    return ParamAddTicket(
      postoId: json['postoId'],
      evento: json['evento'],
      cliente: json['cliente'],
      ticketPrice: json['ticketPrice'],
    );
  }

  Map<String, dynamic> toJson() => {
    'postoId': postoId,
    'evento': evento,
    'cliente': cliente,
    'ticketPrice': ticketPrice,
  };

  @override
  String toString() {
    return '$postoId';
  }


}