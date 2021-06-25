import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) async {
    // Call the user's CollectionReference to add a new user
    if (await isDuplicateEmail(user.email)) {
      return userCollection
          .add({
            'name': user.displayName, // John Doe
            'email': user.email, // Stokes and Sons
            'displayPic': user.photoURL // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  Future<bool> isDuplicateEmail(String? email) async {
    final QuerySnapshot result =
        await userCollection.where('email', isEqualTo: email).limit(1).get();
    return result.docs.length == 0;
  }
}
