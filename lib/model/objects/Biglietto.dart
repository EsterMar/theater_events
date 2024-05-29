import 'Cliente.dart';
import 'Evento.dart';
import 'Posto.dart';

class Biglietto {
  int? id;
  double? price;
  String? name;
  Cliente? cliente;
  Evento? evento;
  Posto? posto;


  //uso required perché il valore di id non deve essere nullo essendo la chiave nel DB
  Biglietto({this.id, this.price, this.name, this.cliente, this.evento, this.posto});

    factory Biglietto.fromJson(Map<String, dynamic> json) {
    return Biglietto(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      cliente: json['cliente']!= null ? Cliente.fromJson(json['cliente']) : null,
      evento: json['evento']!= null ? Evento.fromJson(json['evento']) : null,
      posto: json['posto'] != null ? Posto.fromJson(json['posto']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'price': price,
    'name': name,
    'cliente': cliente?.toJson(),
    'evento': evento?.toJson(),
    'posto': posto?.toJson(),
  };

    void setName(String clientName){
      name= clientName;
  }

  @override
  String toString() {
    return '${cliente.toString()} ${price.toString()}';
  }


}