library firestore_search;

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService<T> {
  final String? collectionName;
  final String? docsName;
  final String? subCollectionName;
  final String? searchBy;
  final List Function(QuerySnapshot)? dataListFromSnapshot;
  final int? limitOfRetrievedData;

  FirestoreService({
    this.collectionName,
    this.docsName,
    this.subCollectionName,
    this.searchBy,
    this.dataListFromSnapshot,
    this.limitOfRetrievedData,
  });
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<List> searchSubData(String query) {
    final collectionReference = firebaseFirestore
        .collection(collectionName!)
        .doc(docsName)
        .collection(subCollectionName!);
    return query.isEmpty
        ? Stream.empty()
        : collectionReference
            .orderBy('$searchBy', descending: false)
            .where('$searchBy', isGreaterThanOrEqualTo: query)
            .where('$searchBy', isLessThan: query + 'z')
            .limit(limitOfRetrievedData!)
            .snapshots()
            .map(dataListFromSnapshot!);
  }

  Stream<List> searchData(String query) {
    final collectionReference = firebaseFirestore.collection(collectionName!);
    return query.isEmpty
        ? Stream.empty()
        : collectionReference
            .orderBy('$searchBy', descending: false)
            .where('$searchBy', isGreaterThanOrEqualTo: query)
            .where('$searchBy', isLessThan: query + 'z')
            .limit(limitOfRetrievedData!)
            .snapshots()
            .map(dataListFromSnapshot!);
  }
}
