import 'package:book_wave/models/boat_service.dart';
import 'package:book_wave/providers/data_noti.dart';
import 'package:book_wave/providers/dummy_provider.dart';
import 'package:book_wave/screens/passenger_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceDetails extends ConsumerWidget {
  const ServiceDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servNoti = ref.read(dataManipulator.notifier);
    final services = ref.watch(dataManipulator);

    final dumData = ref.watch(dummyProvider);
    final dumDataNotifier = ref.read(dummyProvider.notifier);

    final whichService = services.when(
      data: (data) {
        for (BoatService brc in dumData) {
          if (brc.isSelected) {
            return brc;
          }
        }
        if (data.isNotEmpty) {
          for (BoatService brc in data) {
            if (brc.isSelected) {
              return brc;
            }
          }
        } else {
          return BoatService(
            id: "",
            serviceName: "",
            description: "",
            rate: "",
            image: "",
            avlbSeats: "",
            isSelected: false,
          );
        }
      },
      error: (error, stackTrace) {
        print("error at service details screen: $error");
        return null;
      },
      loading: () {
        return null;
      },
    );

    if (whichService == null || !whichService.isSelected) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No service selected",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    Widget content = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              whichService.image.isNotEmpty
                  ? (whichService.image.startsWith('http') ||
                          whichService.image.startsWith('https'))
                      ? Image.network(
                          whichService.image,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          filterQuality: FilterQuality.high,
                          height: 400,
                        )
                      : Image.asset(
                          whichService.image,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          filterQuality: FilterQuality.high,
                          height: 400,
                        )
                  : const CircularProgressIndicator(color: Colors.blue),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      child: IconButton(
                        onPressed: () {
                          if (dumData.contains(whichService)) {
                            dumDataNotifier.toggleSelectedStatus(whichService);
                          } else {
                            servNoti.toggleSelectedStatus(whichService);
                          }
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white54,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share,
                            size: 24, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  whichService.serviceName,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(whichService.description),
                const Divider(color: Colors.black12),
                const Text("Amenities", style: TextStyle(fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (whichService.amenities != null &&
                          whichService.amenities!.isNotEmpty)
                        for (String s in whichService.amenities!) Text("• $s"),
                    ],
                  ),
                ),
                const Divider(color: Colors.black12),
                const Text("Safety Features", style: TextStyle(fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (whichService.safetyFeatures != null &&
                          whichService.safetyFeatures!.isNotEmpty)
                        for (String s in whichService.safetyFeatures!)
                          Text("• $s"),
                    ],
                  ),
                ),
                const Divider(color: Colors.black12),
                if (whichService.specialNotes != null &&
                    whichService.specialNotes!.isNotEmpty)
                  Column(
                    children: [
                      const Text("Special Notes",
                          style: TextStyle(fontSize: 18)),
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (String s in whichService.specialNotes!)
                              Text("• $s"),
                          ],
                        ),
                      ),
                      const Divider(
                          color: Colors.black12, indent: 15, endIndent: 15),
                    ],
                  ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.5),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(23),
                        right: Radius.circular(23),
                      )),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PassengerDetails(),
                        ),
                      );
                    },
                    label: const Text(
                      "Go to passenger details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (dumData.contains(whichService)) {
            dumDataNotifier.toggleSelectedStatus(whichService);
          } else {
            servNoti.toggleSelectedStatus(whichService);
          }
          print("popped from service details screen");
        }
      },
      child: Scaffold(
        body: content,
      ),
    );
  }
}
