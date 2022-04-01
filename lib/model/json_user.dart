class UserModel {
  final String address;
  final double lat;
  final double lng;
  final String phone;
  final String sellerAvatar;
  final String sellerEmail;
  final String sellerName;
  final String sellerUID;
  final String status;

  UserModel({
    required this.address,
    required this.lat,
    required this.lng,
    required this.phone,
    required this.sellerAvatar,
    required this.sellerEmail,
    required this.sellerName,
    required this.sellerUID,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
      phone: json['phone'],
      sellerAvatar: json['sellerAvatar'],
      sellerEmail: json['sellerEmail'],
      sellerName: json['sellerName'],
      sellerUID: json['sellerUID'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['phone'] = phone;
    data['sellerAvatar'] = sellerAvatar;
    data['sellerEmail'] = sellerEmail;
    data['sellerName'] = sellerName;
    data['sellerUID'] = sellerUID;
    data['status'] = status;
    return data;
  }
}
