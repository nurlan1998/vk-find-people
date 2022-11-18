class VkListUsers {
  final List<VkListUsersItem> listUsersItem;

  VkListUsers({
    required this.listUsersItem,
  });

  factory VkListUsers.fromJson(dynamic json) {
    final items = <VkListUsersItem>[
      for(var entry in json['items']) VkListUsersItem.fromJson(entry)
    ];

    return VkListUsers(listUsersItem: items);
  }
}

class VkListUsersItem {
  int id;
  String firstName;
  String lastName;
  String? phone;

  String? photo200;

  VkListUsersItem({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.photo200,
  });

  factory VkListUsersItem.fromJson(dynamic json) {
    return VkListUsersItem(
        id: json['id'] ?? 'unknown',
        firstName: json['first_name'] ?? 'unknown',
        lastName: json['last_name'] ?? 'unknown',
        photo200: json['photo_200'] ?? 'unknown');
  }
}
