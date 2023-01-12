import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pera/src/view/login/model/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();

  factory AuthService() {
    return instance;
  }

  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  Future<AppUser?> currentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return _userFromFirebase(user);
      }

      return null;
    } catch (e) {
      print("$e");
      return null;
    }
  }

  AppUser _userFromFirebase(User user) {
    return AppUser.fromFirebase(user);
  }

  Future<AppUser?> signInWithGoogle() async {
    GoogleSignInAccount? account = await _googleAuth.signIn();

    if (account != null) {
      GoogleSignInAuthentication authentication = await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      UserCredential signInUser = await _auth.signInWithCredential(credential);

      if (signInUser.user != null) {
        return _userFromFirebase(signInUser.user!);
      }
    }

    return null;
  }

  Future<AppUser?> signInWithApple() async {
    String rawNonce = generateNonce();
    String nonce = sha256ofString(rawNonce);

    AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ], nonce: nonce);

    OAuthCredential oAuthCredential = OAuthProvider("apple.com")
        .credential(idToken: credential.identityToken, rawNonce: rawNonce);

    UserCredential signInUser =
        await _auth.signInWithCredential(oAuthCredential);

    if (signInUser.user != null) {
      return AppUser.fromFirebase(signInUser.user!);
    }

    return null;
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  signOut() async {
    await _auth.signOut();
  }
}