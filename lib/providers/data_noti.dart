import 'dart:async';
import 'package:async/async.dart';
import 'package:book_wave/models/boat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataNotifier extends StreamNotifier<List<BoatService>> {
  DataNotifier() : super();

  @override
  Stream<List<BoatService>> build() async* {
    print("Going to load data from stream");

    // Stream to listen for changes in the `service providers` collection
    await for (var serviceProvidersSnapshot in FirebaseFirestore.instance
        .collection('service providers')
        .snapshots()) {
      // List to store all the boat service streams
      List<Stream<List<BoatService>>> allBoatsStreams = [];

      // Loop through each document in the service providers collection
      for (var doc in serviceProvidersSnapshot.docs) {
        // Create a stream for each 'available boats' sub-collection
        var boatsStream = FirebaseFirestore.instance
            .collection('service providers')
            .doc(doc.id)
            .collection('available boats')
            .snapshots()
            .map((subCollectionSnapshot) => subCollectionSnapshot.docs
                .map((boatDoc) =>
                    BoatService.fromMap(boatDoc.id, boatDoc.data()))
                .toList());

        // Add the sub-collection stream to the list
        allBoatsStreams.add(boatsStream);
      }

      // Combine all the sub-collection streams into one
      yield* StreamZip(allBoatsStreams).map(
          (listOfLists) => listOfLists.expand((element) => element).toList());
    }
  }

  void toggleSelectedStatus(BoatService bSrvc) {
    state.whenData(
      (valueInState) {
        final updatedServices = valueInState.map(
          (b) {
            if (b.id == bSrvc.id) {
              return b.copyWith(isSelected: !b.isSelected);
            }
            return b;
          },
        ).toList();
        state = AsyncData(updatedServices);
        print("state changed");
        print("status of ${bSrvc.id} is updated");
      },
    );
  }
}

final dataManipulator = StreamNotifierProvider<DataNotifier, List<BoatService>>(
  () => DataNotifier(),
);
