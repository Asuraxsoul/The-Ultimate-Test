import 'package:flutter/material.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';
import 'package:the_ultimate_test/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_ultimate_test/screens/sign_in_screen.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

Future<CollectionReference> getClimberTestId() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    MaterialPageRoute(builder: (_) => SignInScreen());
    return "hey!" as CollectionReference;
  } else {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    final String? email = user.email;
    final QuerySnapshot result =
        await userCollection.where('email', isEqualTo: email).limit(1).get();

    final userdocid = result.docs.first.id;

    final CollectionReference climberTestCollection =
        userCollection.doc(userdocid).collection("climberTestResults");

    return climberTestCollection;
  }
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String email = FirebaseAuth.instance.currentUser!.email as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: ReusableHeader.getAppBar("Your Achievements"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text("Achievements, try use Hero widget here"),
                ),
                Row(),
                StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('users').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: const Text('Loading...'));
                    } else {
                      print(snapshot.data!.docs.length);
                      //print(snapshot.data.docs[0]['email']);
                      List<DocumentSnapshot> documentsUnfiltered =
                          snapshot.data!.docs;
                      List<DocumentSnapshot> documents =
                          List.empty(growable: true);
                      documentsUnfiltered.forEach((doc) {
                        if (doc['email'] == email) {
                          documents.add(doc);
                        } else {}
                      });
                      return ExpansionTileList(
                        firestore: firestore,
                        documents: documents,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExpansionTileList extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final FirebaseFirestore firestore;

  ExpansionTileList({
    required this.documents,
    required this.firestore,
  });

  List<Widget> _getChildren() {
    List<Widget> children = [];
    documents.forEach((doc) {
      children.add(
        ProjectsExpansionTile(
          name: doc['name'],
          projectKey: doc.id,
          firestore: firestore,
        ),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: _getChildren(),
    );
  }
}

class ProjectsExpansionTile extends StatelessWidget {
  ProjectsExpansionTile({
    required this.projectKey,
    required this.name,
    required this.firestore,
  });

  final String projectKey;
  final String name;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    PageStorageKey _projectKey = PageStorageKey('$projectKey');

    return ExpansionTile(
      key: _projectKey,
      title: Text(
        'name: $name',
        style: TextStyle(fontSize: 28.0),
      ),
      children: <Widget>[
        StreamBuilder(
            stream: firestore
                .collection('users')
                .doc(projectKey)
                .collection('climberTestResults')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              //final int surveysCount = snapshot.data.documents.length;
              List<DocumentSnapshot> documents = snapshot.data!.docs;

              List<Widget> surveysList = [];
              documents.forEach((doc) {
                PageStorageKey _surveyKey = new PageStorageKey('${doc.id}');

                surveysList.add(ListTile(
                  key: _surveyKey,
                  title: Text('${doc['total']}'),
                ));
              });
              return Column(children: surveysList);
            })
      ],
    );
  }
}
