import 'package:book_wave/models/boat_service.dart';
import 'package:book_wave/providers/dummy_provider.dart';
import 'package:book_wave/providers/data_noti.dart';
import 'package:book_wave/screens/service_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfServices extends ConsumerWidget {
  const ListOfServices({
    super.key,
    required this.boatService,
  });

  final BoatService boatService;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dumData = ref.watch(dummyProvider);

    final wichPlace = ref.watch(dataManipulator.notifier);
    final dumDataNotifier = ref.read(dummyProvider.notifier);

    return InkWell(
      onTap: () {
        print("going to show service details");

        if (dumData.contains(boatService)) {
          dumDataNotifier.toggleSelectedStatus(boatService);
          print("toggled");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ServiceDetails(),
            ),
          );
          return;
        }

        wichPlace.toggleSelectedStatus(boatService);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ServiceDetails(),
          ),
        );
        print("printed service details");
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: boatService.image.isNotEmpty
                        ? boatService.image.startsWith('http') ||
                                boatService.image.startsWith('https')
                            ? Image.network(
                                boatService.image,
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              )
                            : Image.asset(
                                boatService.image,
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              )
                        : const Center(
                            child: SizedBox(
                              width: 50,
                              child: LinearProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 20,
                        width: 70,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(23),
                            right: Radius.circular(23),
                          ),
                          color: Colors.white70,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 3),
                            const Icon(Icons.person, size: 15),
                            const SizedBox(width: 5),
                            Text(
                              "${boatService.avlbSeats} seats",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    //code to change icon to filled icon
                    //when the user want to add this service to liked screen
                    //or something
                  },
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
            Text(
              boatService.serviceName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
            ),
            Text(boatService.description),
            Text(
              boatService.rate,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
