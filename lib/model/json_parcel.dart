class Order {
  final String parcelImageUrl;
  final String title;
  final String detail;
  final String weight;
  final String phone;
  final String dropphone;
  final String pick;
  final String drop;
  final String price;
  final bool taken;
  final bool approved;
  final bool userCompleted;
  final bool riderCompleted;
  final String sellerUID;
  final String rid;
  final int completedDate;

  Order({
    required this.title,
    required this.parcelImageUrl,
    required this.sellerUID,
    required this.rid,
    required this.detail,
    required this.weight,
    required this.phone,
    required this.dropphone,
    required this.pick,
    required this.drop,
    required this.price,
    required this.taken,
    required this.approved,
    required this.userCompleted,
    required this.riderCompleted,
    required this.completedDate,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        title: json['title'],
        detail: json['detail'],
        weight: json['weight'],
        phone: json['phone'],
        dropphone: json['dropphone'],
        pick: json['pick'],
        drop: json['drop'],
        price: json['price'],
        taken: json['taken'],
        approved: json['approved'],
        sellerUID: json['sellerUID'],
        parcelImageUrl: json['parcelImageUrl'],
        userCompleted: json['userCompleted'],
        riderCompleted: json['riderCompleted'],
        completedDate: json['completedDate'],
        rid: json['rid']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['detail'] = detail;
    data['weight'] = weight;
    data['phone'] = phone;
    data['dropphone'] = dropphone;
    data['pick'] = pick;
    data['drop'] = drop;
    data['price'] = price;
    data['taken'] = taken;
    data['approved'] = approved;
    data['sellerUID'] = sellerUID;
    data['parcelImageUrl'] = parcelImageUrl;
    data['rid'] = rid;
    data['userCompleted']= userCompleted;
    data['riderCompleted']= riderCompleted;
    data['completedDate']= completedDate;
    return data;
  }
}
