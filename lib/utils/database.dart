import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_ultimate_test/widgets/result_card.dart';

class DatabaseService {
  Future<void> addUser(User user) async {
    // collection reference
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    if (await isDuplicateEmail(user.email, userCollection)) {
      return userCollection
          .add({
            'name': user.displayName,
            'email': user.email,
            'displayPic': user.photoURL
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  Future<bool> isDuplicateEmail(
      String? email, CollectionReference userCollection) async {
    final QuerySnapshot result =
        await userCollection.where('email', isEqualTo: email).limit(1).get();
    return result.docs.length == 0;
  }

  Future<void> addClimberTestResult(
      User? user, ConvertedResults results, DateTime dateTime) async {
    if (user == null) {
      //Do nothing
    } else {
      // collection reference
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      final String? email = user.email;

      final QuerySnapshot result =
          await userCollection.where('email', isEqualTo: email).limit(1).get();

      final CollectionReference climberTestCollection =
          result.docs[0].reference.collection("climberTestResults");

      return climberTestCollection
          .add({
            'fingerStrength': results.result1,
            'pullUp': results.result2,
            'coreTime': results.result3,
            'hangTime': results.result4,
            'total': results.total,
            'dateTime': dateTime
          })
          .then((value) => print("Result Added"))
          .catchError((error) => print("Failed to add result: $error"));
    }
  }
}
