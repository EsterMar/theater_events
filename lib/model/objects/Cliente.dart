class Cliente {
  int? id;
  String? code;
  String? name;
  String? surname;
  String? telephone_number;
  String? email;
  String? address;

Cliente.empty();

  Cliente({
    this.id,
    this.code,
    this.name,
    this.surname,
    this.telephone_number,
    this.email,
    this.address,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      surname: json['surname'],
      telephone_number: json['telephone_number'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'surname': surname,
    'telephone_number': telephone_number,
    'email': email,
    'address': address,
  };

  @override
  String toString() {
    return '$name $surname';
  }


}