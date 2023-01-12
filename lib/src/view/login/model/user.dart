import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String userID;
  String name;
  String picsUrl;
  String email;

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'picsName': picsUrl
    };
  }

  AppUser.fromFirebase(User user)
      : userID = user.uid,
        name = user.displayName ?? "user${user.uid}",
        picsUrl = user.photoURL ?? "",
        email = user.email ?? "";

  AppUser.fromMap(Map<String, dynamic> user)
      : userID = user['userID'],
        name = user['name'],
        picsUrl = user['picsName'],
        email = user['email'];
}