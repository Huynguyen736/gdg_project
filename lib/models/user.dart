import 'package:cloud_firestore/cloud_firestore.dart';

class Userdata {

  final String uid;

  Userdata({ required this.uid });

  // get user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('members') // Replace 'users' with your collection name
          .doc(uid)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        // Handle the case where the document does not exist
        print('User document not found');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

}