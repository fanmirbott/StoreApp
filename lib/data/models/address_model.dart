class AddressModel {
  final int id;
  final String title;
  final String fullAddress;
  final double lat;
  final double lng;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      title: json['title'],
      fullAddress: json['fullAddress'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      isDefault: json['isDefault'] ?? false,
    );
  }
}