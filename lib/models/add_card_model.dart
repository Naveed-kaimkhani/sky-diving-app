class AddCardModel {
  String? title;
  String? price;
  String? dateOfFirst;
  String? dateSub;
  String? deliveryOption;
  String? deliveryDesSub;
  String? rentalPeriod;
  String? rentalPeriodSub;
  String? Canopy;
  String? sizeSub;
  String? quantity;

  AddCardModel({
    this.title,
    this.price,
    this.dateOfFirst,
    this.dateSub,
    this.deliveryOption,
    this.deliveryDesSub,
    this.rentalPeriod,
    this.rentalPeriodSub,
    this.Canopy,
    this.sizeSub,
    this.quantity,
  });

  factory AddCardModel.fromJson(Map<String, dynamic> json) {
    return AddCardModel(
      title: json['title'],
      price: json['price'],
      dateOfFirst: json['dateOfFirst'],
      dateSub: json['dateSub'],
      deliveryOption: json['deliveryOption'],
      deliveryDesSub: json['deliveryDesSub'],
      rentalPeriod: json['rentalPeriod'],
      rentalPeriodSub: json['rentalPeriodSub'],
      Canopy: json['Canopy'],
      sizeSub: json['sizeSub'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'dateOfFirst': dateOfFirst,
      'dateSub': dateSub,
      'deliveryOption': deliveryOption,
      'deliveryDesSub': deliveryDesSub,
      'rentalPeriod': rentalPeriod,
      'rentalPeriodSub': rentalPeriodSub,
      'Canopy': Canopy,
      'sizeSub': sizeSub,
      'quantity': quantity,
    };
  }
}
