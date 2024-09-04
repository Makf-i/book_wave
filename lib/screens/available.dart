import 'package:book_wave/data/dummy_data.dart';
import 'package:book_wave/providers/data_noti.dart';
import 'package:book_wave/widgets/list_of_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

const formatter = DateFormat;

class AvailableBoats extends ConsumerStatefulWidget {
  const AvailableBoats({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  ConsumerState<AvailableBoats> createState() => _AvailableBoatsState();
}

class _AvailableBoatsState extends ConsumerState<AvailableBoats> {
  late String day;
  late String dayName;
  late String month;
  late String year;

  @override
  void initState() {
    super.initState();

    day = DateFormat('d').format(widget.date);
    dayName = DateFormat('EEEE').format(widget.date);
    month = DateFormat('MMMM').format(widget.date);
    year = DateFormat('y').format(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    final availableServices = ref.watch(dataManipulator);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          print("Popped from available screen $result");
        } else {
          print("Cancelled pop");
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: const Color.fromARGB(255, 130, 186, 233),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Boarding Point",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "$dayName, $month $day, $year",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                leading: IconButton(
                    onPressed: () {
                      print("popping");
                      Navigator.of(context).pop();
                      print("rsetting");
                      //ref.read(dataManipulator.notifier).reset();
                      print("resetted");
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Showing available boats",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        body: availableServices.when(
          data: (data) {
            final comb = data + dums;
            return ListView.builder(
              
              dragStartBehavior: DragStartBehavior.start,
              itemCount: comb.length,
              itemBuilder: (context, index) {
                print(comb[index].serviceName);
                return ListOfServices(
                  boatService: comb[index],
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text("Error: ${error.toString()}",
                  style: const TextStyle(color: Colors.red)),
            );
          },
          loading: () {
            return const Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: SizedBox(
                  width: 50,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
