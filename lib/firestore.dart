import 'package:auction_app/modal.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final CollectionReference productsCollection = FirebaseFirestore.instance
      .collection('products');

  Future<void> markProductForAuction(Auction auction) async {
    await productsCollection.doc(auction.id.toString()).set(auction.toMap());
  }

  Future<List<Auction>> getAuctionProducts() async {
    QuerySnapshot querySnapshot = await productsCollection.where(
        'markedForAuction', isEqualTo: 1).get();
    return querySnapshot.docs.map((doc) {
      return Auction(
        id: int.parse(doc.id),
        name: doc['name'],
        category: doc['category'],
        price: doc['price'],
        markedForAuction: true,
      );
    }).toList();
  }

  Future<void> removeProductFromAuction(Auction auction) async {
    await productsCollection.doc(auction.id.toString()).update(
        {'markedForAuction': 0});
  }
}