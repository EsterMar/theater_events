import '../objects/Cliente.dart';
import '../objects/Evento.dart';

class ParamAddTicket {
  int? postoId;
  Evento? evento;
  Cliente? cliente;
  double? ticketPrice;
  String? clientName;

  ParamAddTicket({this.postoId, this.evento, this.cliente, this.ticketPrice, this.clientName});

  factory ParamAddTicket.fromJson(Map<String, dynamic> json) {
    return ParamAddTicket(
      postoId: json['postoId'],
      evento: json['evento']!= null ? Evento.fromJson(json['evento']) : null,
      cliente: json['cliente']!= null ? Cliente.fromJson(json['cliente']) : null,
      ticketPrice: json['ticketPrice'],
      clientName: json['clientName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'postoId': postoId,
    'evento': evento?.toJson(),
    'cliente': cliente?.toJson(),
    'ticketPrice': ticketPrice,
    'clientName': clientName,
  };

  @override
  String toString() {
    return '$postoId' '$clientName';
  }
}
