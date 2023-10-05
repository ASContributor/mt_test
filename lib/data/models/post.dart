class Post {
  final String first_name;
  final String last_name;
  final String avatar;
  final String email;
  final int id;

  Post.fromJson(Map json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        avatar = json['avatar'],
        email = json['email'],
        id = json['id'];
}
