import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  late final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference memberCollection = FirebaseFirestore.instance.collection("members");

  Future updateUserData(String name, String email, String branch) async {
    return await memberCollection.doc(uid).set({
      "date": "07-03-2006",
      "email": email,
      "role": "Member",
      "name": name,
      "gen": "Gen 4",
      "phone": "",
      "branch": branch
    });
  }


  // get stream
Stream<QuerySnapshot> get members {
    return memberCollection.snapshots();
}

}