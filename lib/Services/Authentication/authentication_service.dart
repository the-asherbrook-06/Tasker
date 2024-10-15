import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("Google sign-in aborted by user");
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          await _createUserInFirestore(user);
        }

        return user;
      } else {
        print("Google sign-in failed: Missing tokens");
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
    return null;
  }


  Future<void> _createUserInFirestore(User user) async {
    DocumentReference userRef = _firestore.collection('Users').doc(user.email);

    DocumentSnapshot userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      await userRef.set({
        'User_Data': {
          'userID': user.uid,
          'userName': user.displayName,
          'userEmail': user.email,
          'photoURL': user.photoURL,
        },
        'User_Preferences': {
        
          'theme': 'light',
          'notificationsEnabled': true,
        },
      });
      print('User entry created in Firestore');
    } else {
      print('User already exists in Firestore');
    }
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }


  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
