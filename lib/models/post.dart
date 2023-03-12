import 'package:cloud_firestore/cloud_firestore.dart';
// TO avoid bugs in future relateed data saving in firebase model is created
class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final  datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post(
      {required this.username,
      required this.uid,
      required this.description,
      required this.datePublished,
      required this.likes,
      required this.postId,
      required this.postUrl,
      required this.profImage});

  // Creating method to save this object in json format
  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      profImage: snapshot["profImage"],
      likes: snapshot["likes"],
      postUrl: snapshot["postUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postUrl": postUrl,
      };

}
