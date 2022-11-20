class VkUserInfo {
  String firstName;
  int id;
  String lastName;
  bool canAccessClosed;
  bool isClosed;

  bool hasPhoto;
  String? photo100;
  String? photo200;

  VkUserInfo({
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.canAccessClosed,
    required this.isClosed,
    this.hasPhoto = false,
    this.photo100,
    this.photo200,
  });

  factory VkUserInfo.fromJson(Map<String, dynamic> json) {
    return VkUserInfo(
      firstName: json['first_name'],
      id: json['id'],
      lastName: json['last_name'],
      canAccessClosed: json['can_access_closed'],
      isClosed: json['is_closed'],
      hasPhoto: json['has_photo'] != null ? json['has_photo'] != 0 : false,
      photo100: json['photo_100'],
      photo200: json['photo_200'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['id'] = id;
    data['last_name'] = lastName;
    data['can_access_closed'] = canAccessClosed;
    data['is_closed'] = isClosed;
    data['photo100'] = photo100;
    data['photo200'] = photo200;
    data['has_photo'] = hasPhoto;
    return data;
  }
}