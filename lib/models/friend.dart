class Friend {
  final int id;
  final String name;
  final String email;
  final String? status;
  final int? friendshipId;

  Friend({
    required this.id,
    required this.name,
    required this.email,
    this.status,
    this.friendshipId,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      friendshipId: json['friendship_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      if (status != null) 'status': status,
      if (friendshipId != null) 'friendship_id': friendshipId,
    };
  }
}
