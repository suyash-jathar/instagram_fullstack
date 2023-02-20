// TO avoid bugs in future relateed data saving in firebase model is created
class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,  
  });

// Creating method to save this object in json format
  Map<String,dynamic> toJson(){
    return {
      'username':username,
      'uid':uid,
      'email':email,
      'photoUrl':photoUrl,
      'bio':bio,
      'followers':followers,
      'following':following,
    };
  }

}