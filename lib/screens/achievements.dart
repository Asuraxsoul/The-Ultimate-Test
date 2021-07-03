import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_ultimate_test/screens/sign_in_screen.dart';
import 'package:the_ultimate_test/widgets/achievement_result_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      backgroundColor: Colors.transparent,
      appBar: ReusableHeader.getAppBar("Your Achievements"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color(0xFF330867),
                Color(0xFF30cfd0),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('users').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: const Text('Loading...'));
                    } else {
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

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.all(defaultPadding),
              textColor: Colors.lightBlueAccent,
              collapsedTextColor: Color(0xFF82BBFF),
              backgroundColor: Color(0x77A7FFEB),
              collapsedBackgroundColor: Color(0x33A7FFEB),
              key: _projectKey,
              title: Text(
                'Ultimate Climber Test Results',
                style: TextStyle(
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.left,
              ),
              children: <Widget>[
                StreamBuilder(
                    stream: firestore
                        .collection('users')
                        .doc(projectKey)
                        .collection('climberTestResults')
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return const Text('Loading...');
                      List<DocumentSnapshot> documents = snapshot.data!.docs;

                      List<Widget> testResultList = [];
                      documents.forEach((doc) {
                        testResultList.add(
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                0, 0, 0, defaultPadding / 2),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    AchievementResultCard(
                                      tag: doc.id,
                                      fingerStrength: doc['fingerStrength'],
                                      pullUp: doc['pullUp'],
                                      coreTime: doc['coreTime'],
                                      hangTime: doc['hangTime'],
                                      dateTime: DateFormat.yMMMd()
                                          .add_jm()
                                          .format(doc['dateTime'].toDate()),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 10,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1, color: Colors.grey[300]!),
                                      ),
                                    ),
                                  ),
                                  Stack(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Hero(
                                          tag: '${doc.id}',
                                          child: SvgPicture.asset(
                                            rankPic(rankResult(doc['total'])),
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 90,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding / 2,
                                        ),
                                        child: Text(
                                          '${DateFormat.yMMMd().add_jm().format(doc['dateTime'].toDate())}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  SizedBox(height: 5),
                                  Text(
                                    'Total Score: ${doc['total']} / 40',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'View Details!',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CustomPageRoute(AchievementResultCard(
                                          tag: doc.id,
                                          fingerStrength: doc['fingerStrength'],
                                          pullUp: doc['pullUp'],
                                          coreTime: doc['coreTime'],
                                          hangTime: doc['hangTime'],
                                          dateTime: DateFormat.yMMMd()
                                              .add_jm()
                                              .format(doc['dateTime'].toDate()),
                                        )),
                                      );
                                    },
                                  ),
                                  //SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                      return Container(
                        // child: Column(
                        //   children: testResultList,
                        // ),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView(
                          children: testResultList,
                          key: _projectKey,
                          scrollDirection: Axis.vertical,
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
        SizedBox(height: defaultPadding),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.all(defaultPadding),
              textColor: basicColorTeal,
              collapsedTextColor: basicColorGreen,
              backgroundColor: Color(0x66A7FFEB),
              collapsedBackgroundColor: Color(0x22A7FFEB),
              title: Text(
                'Ultimate FBI Test \nResults',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
