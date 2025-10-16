class AddressModel {
  final int? id;
  final String nickname;
  final String fullAddress;
  final double? lat;
  final double? lng;
  final bool isDefault;

  AddressModel({
    this.id,
    required this.nickname,
    required this.fullAddress,
    this.lat,
    this.lng,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as int?,
      nickname: json['nickname'] as String? ?? 'No Nickname',
      fullAddress: json['fullAddress'] as String? ?? 'No Address',
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nickname": nickname,
      "fullAddress": fullAddress,
      "lat": lat ?? 0,
      "lng": lng ?? 0,
      "isDefault": isDefault,
    };
  }

  AddressModel copyWith({
    int? id,
    String? nickname,
    String? fullAddress,
    double? lat,
    double? lng,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      fullAddress: fullAddress ?? this.fullAddress,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
