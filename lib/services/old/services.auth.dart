// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:katakara_investor/helper/helper.function.dart';
// import 'package:katakara_investor/services/services.dart';
// import 'package:katakara_investor/services/services.database.dart';

// class AuthService {
//   static final _firebaseAuth = FirebaseAuth.instance;

//   static dynamic checkError(String errorCode) {
//     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     // switch (errorCode) {
//     //   case "too-many-requests":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "weak-password":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "email-already-in-use":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "app-not-authorized":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "credential-already-in-use":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "invalid-user-token":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "invalid-email":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "invalid-credential":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   case "operation-not-allowed":
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     //   default:
//     //     return HC.failedMessage(message: errorCode.replaceAll('-', ' '));
//     // }
//   }

//   static Future<Map<String, dynamic>> signUp(email, password,
//       {required Map<String, dynamic> data}) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       if (userCredential.user!.uid.isNotEmpty) {
//         log("starting save shot");
//         final userDoc = await FStore.storeDataToCollection(
//           data: data,
//           id: userCredential.user!.uid,
//           collection: FCollection.users(),
//         );
//         log(userDoc.toString());
//         // if(userDoc.){}
//         return HC.successMessage(
//             message: "Account Created succesful", data: userDoc);
//       }
//     } on FirebaseException catch (firebaseError) {
//       return checkError(firebaseError.code.toString());
//     } catch (e) {
//       return HC.failedMessage(message: e.toString());
//     }
//     return HC.failedMessage(message: "An error occured, cannot sign up.");
//   }

//   static Future<Map<String, dynamic>> signIn(email, password) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       if (userCredential.user!.uid.isNotEmpty) {
//         final userDoc = await FStore.fetchOneById(
//             id: userCredential.user!.uid, collection: FCollection.users());
//         log(userDoc.toString());
//         return HC.successMessage(
//             message: "Account Created succesful", data: userDoc);
//       }
//     } on FirebaseException catch (firebaseError) {
//       return checkError(firebaseError.code.toString());
//     } catch (e) {
//       return HC.failedMessage(message: e.toString());
//     }
//     return HC.failedMessage(message: "An error occured, cannot login.");
//   }

//   static void signOut() {
//     _firebaseAuth.signOut();
//   }
// }
