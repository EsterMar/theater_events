import 'Cliente.dart';
import 'Evento.dart';
import 'Posto.dart';

class Biglietto {
  int? id;
  double? price;
  Cliente? cliente;
  Evento? evento;
  Posto? posto;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Biglietto({this.id, this.price, this.cliente, this.evento, this.posto});

    factory Biglietto.fromJson(Map<String, dynamic> json) {
    return Biglietto(
      id: json['id'],
      price: json['price'],
      cliente: json['cliente'],
      evento: json['evento'],
      posto: json['posto'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'cliente': cliente,
    'evento': evento,
    'posto': posto,
  };

  @override
  String toString() {
    return '${cliente.toString()} ${price.toString()}';
  }


}