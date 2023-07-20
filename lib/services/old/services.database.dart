// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:katakara_investor/helper/helper.function.dart';

// class FStore {
//   static _failedMessage({String? message}) =>
//       {'message': message ?? "process failed", 'status': false};

//   static Future<Map<String, dynamic>> storeDataToCollection(
//       {required Map<String, dynamic> data,
//       required CollectionReference collection,
//       String? id}) async {
//     try {
//       await collection.doc(id).set(data);
//       return HC.successMessage();
//     } catch (e) {
//       return _failedMessage();
//     }
//   }

//   static Future<Map<String, dynamic>> fetchOneById(
//       {required CollectionReference collection, required String id}) async {
//     DocumentSnapshot<Object?> userDoc = await collection.doc(id).get();

//     if (userDoc.exists) {
//       return HC.successMessage(
//           message: "Fetch successful",
//           data: userDoc.data() as Map<String, dynamic>);
//     }

//     return _failedMessage(message: 'Unable to fetch data');
//   }
// }
