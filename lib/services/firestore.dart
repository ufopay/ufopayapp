import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ufopayapp/services/auth.dart';
import 'package:ufopayapp/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<CreditCard>> getCards() async {
    var ref = _db.collection('card');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var creditcards = data.map((d) => CreditCard.fromJson(d));
    return creditcards.toList();
  }

  Future<UfoUserInfo> getUfoUserInfo(String? userId) async {
    var ref = _db.collection('userInfo').doc(userId);
    var snapshot = await ref.get();
    return UfoUserInfo.fromJson(snapshot.data() ?? {});
  }

  Stream<UfoUserInfo> streamUfoUserInfo() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('userInfo').doc(user.uid);
        return ref.snapshots().map((doc) => UfoUserInfo.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([UfoUserInfo()]);
      }
    });
  }

  Future<void> updateUfoUserInfo(CreditCard creditCard) {
    var user = AuthService().user!;
    var ref = _db.collection('userInfo').doc(user.uid);

    var data = {
      'uid': user.uid,
      'cardnames': FieldValue.arrayUnion([creditCard.name]),
    };

    return ref.set(data, SetOptions(merge: true));
  }

  Future<void> deleteUfoUserInfo(String creditCardName) {
    var user = AuthService().user!;
    var ref = _db.collection('userInfo').doc(user.uid);

    var data = {
      'cardnames': FieldValue.arrayRemove([creditCardName]),
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
