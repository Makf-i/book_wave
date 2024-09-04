import 'package:book_wave/models/boat_service.dart';
import 'package:book_wave/providers/data_noti.dart';
import 'package:book_wave/providers/dummy_provider.dart';
import 'package:book_wave/providers/passenger_register.dart';
import 'package:book_wave/widgets/otherwids/dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SrcDestin extends ConsumerStatefulWidget {
  const SrcDestin({super.key});

  @override
  ConsumerState<SrcDestin> createState() => _SrcDestinState();
}

class _SrcDestinState extends ConsumerState<SrcDestin> {
  @override
  Widget build(BuildContext context) {
    final noOfPassengers = ref.watch(passengerProvider);
    const  initPass = 1;

    final services = ref.watch(dataManipulator);
    final dumDataProvider = ref.watch(dummyProvider);
    final whichService = services.when(
      data: (data) {
        final comb = data + dumDataProvider;

        for (BoatService brc in comb) {
          if (brc.isSelected == true) {
            return brc;
          }
        }
      },
      error: (error, stackTrace) {},
      loading: () {},
    );

    return Card(
      elevation: 2.5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(whichService!.serviceName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '7:00 AM',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'From',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Custom dashed line
                    DashedLine(
                      qty: 30,
                      dashWidth: 2.0,
                      dashHeight: 1.0,
                      mrg: 1,
                    ),
                    // Boat Icon
                    Icon(
                      Icons.directions_boat,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '3:00 PM',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'To',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 32.0),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.black),
                const SizedBox(width: 8.0),
                Text(
                  '${noOfPassengers.isEmpty ? initPass : noOfPassengers.length } Seats',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
