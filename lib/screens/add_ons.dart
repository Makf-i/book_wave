import 'package:book_wave/models/addon_model.dart';
import 'package:book_wave/providers/amount_provider.dart';
import 'package:book_wave/providers/dummy_provider.dart';
import 'package:book_wave/providers/addon_provider.dart';
import 'package:book_wave/providers/passenger_register.dart';
import 'package:book_wave/screens/finalization.dart';
import 'package:book_wave/widgets/otherwids/dashed_line.dart';
import 'package:book_wave/widgets/src_destin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddOnsScreen extends ConsumerStatefulWidget {
  const AddOnsScreen({super.key});

  @override
  ConsumerState<AddOnsScreen> createState() => _AddOnsScreenState();
}

class _AddOnsScreenState extends ConsumerState<AddOnsScreen> {
  bool _transportationOptions = true;
  bool _mealSelectionOptions = true;
  bool _otherRecommendationOptions = true;
  bool _insuranceOptions = true;

  bool insuring = false;
  int insureAmount = 50;

  int noOfBreakSnack = 0;
  int noOfPureVegLun = 0;
  int noOfNonVegLunc = 0;

  @override
  Widget build(BuildContext context) {
    final dumMealProvider = ref.watch(dummyMealsProvider);
    final dumMealNotifier = ref.read(dummyMealsProvider.notifier);

    final avlbMealsAddOns = ref.watch(mealsProvider);
    final mealNotifier = ref.read(mealsProvider.notifier);

    final totMeals = avlbMealsAddOns + dumMealProvider;

    final avlbTransAddOns = ref.watch(transportationProvider);
    final transpNotifier = ref.read(transportationProvider.notifier);
    final whichTrnsTogged = avlbTransAddOns.firstWhere(
      (element) => element.isChosen,
      orElse: () => AddOnsModel(
        id: "id",
        name: "name",
        currentRate: 0,
        isChosen: false,
      ),
    );

    final avlbOtherRec = ref.watch(otherRecommsProvider);
    final otherRecommsNotifier = ref.read(otherRecommsProvider.notifier);

    final avlbInsurance = ref.watch(insuranceProvider);
    final insuranceNotifier = ref.read(insuranceProvider.notifier);

    final regPassengers = ref.watch(passengerProvider);
    final adult = regPassengers.where(
      (element) {
        return int.parse(element.age) > 10;
      },
    ).toList();
    final child = regPassengers.where(
      (element) {
        return int.parse(element.age) < 10;
      },
    ).toList();

    final totAmountProv = ref.watch(totalProvider);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          mealNotifier.reset();
          print("popped from add ons screen");
          ref.read(passengerProvider.notifier).reset();
          print("passenger state resetted");
          //print(regPassengers[5].name);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.5),
          title: const Text("Add-ons"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              mealNotifier.reset();
              print("reseted");
              Navigator.of(context).pop();
              ref.read(passengerProvider.notifier).reset();
              print("passenger state resetted");
            },
            icon: const Icon(Icons.close),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const SrcDestin(),
                  const SizedBox(height: 20),
                  const Text(
                    "Additional Services",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Transportation Options",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      if (!_transportationOptions)
                        TextButton(
                          onPressed: () {
                            transpNotifier.toggleTranspReq(whichTrnsTogged);
                            print(whichTrnsTogged.name);
                            setState(() {
                              _transportationOptions = true;
                            });
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                  if (_transportationOptions)
                    const Text(
                      "Cab service pickUp and dropOff at Station; driver details will be shared via WhatsApp.",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13.5),
                    ),
                  if (_transportationOptions &&
                      whichTrnsTogged.isChosen == false)
                    for (AddOnsModel trns in avlbTransAddOns)
                      ListTile(
                        trailing: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              transpNotifier.toggleTranspReq(trns);
                              setState(() {
                                _transportationOptions = false;
                              });
                            },
                          ),
                        ),
                        title: Text(trns.name),
                        subtitle: Text("₹${trns.currentRate}"),
                      ),
                  if (!_transportationOptions &&
                      whichTrnsTogged.isChosen != false)
                    ListTile(
                      trailing: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      title: Text(whichTrnsTogged.name),
                      subtitle: Text("₹${whichTrnsTogged.currentRate}"),
                    ),
                  const DashedLine(
                      qty: 50, dashWidth: 5.0, dashHeight: 1.0, mrg: 1),
                  ////////////////////////////////////////////////////////////////////////

                  // Display meals with appropriate buttons

                  for (AddOnsModel ml in totMeals)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      trailing: ml.isChosen
                          ? Container(
                              height: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(5),
                                      right: Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (ml.count > 1) {
                                        if (dumMealProvider.contains(ml)) {
                                          dumMealNotifier
                                              .decrementMealCount(ml);
                                        }
                                        mealNotifier.decrementMealCount(ml);
                                      } else {
                                        // Toggle off if count drops below 1
                                        if (dumMealProvider.contains(ml)) {
                                          dumMealNotifier.toggleMealReq(ml);
                                        }
                                        mealNotifier.toggleMealReq(ml);
                                        setState(() {
                                          _mealSelectionOptions = true;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text("${ml.count}",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                  IconButton(
                                    visualDensity: const VisualDensity(
                                        horizontal:
                                            VisualDensity.minimumDensity,
                                        vertical: VisualDensity.minimumDensity),
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (dumMealProvider.contains(ml) &&
                                          ml.isChosen) {
                                        dumMealNotifier.updateMealCount(ml);
                                      }
                                      mealNotifier.updateMealCount(ml);
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                if (dumMealProvider.contains(ml) &&
                                    ml.isChosen) {
                                  print("dum meal chosem");
                                  dumMealNotifier.toggleMealReq(ml);
                                }
                                print("stream meal chosem");
                                mealNotifier.toggleMealReq(ml);
                                setState(() {
                                  _mealSelectionOptions = false;
                                });
                              },
                              child: const Text("Add"),
                            ),
                      title: Text(ml.name),
                      subtitle: Text("₹${ml.currentRate}"),
                    ),
                  const DashedLine(
                      qty: 50, dashWidth: 5.0, dashHeight: 1.0, mrg: 1),
                  //other recomm
                  const Text(
                    "Other Recommendations",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 18.1),
                  ),
                  for (AddOnsModel nnM in avlbOtherRec)
                    ListTile(
                      trailing: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: Icon(
                            nnM.isChosen ? Icons.check : Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            otherRecommsNotifier.toggleOtherRecSelection(nnM);
                            setState(() {
                              _otherRecommendationOptions =
                                  !_otherRecommendationOptions;
                            });
                          },
                        ),
                      ),
                      title: Text(nnM.name),
                      subtitle: Text("₹${nnM.currentRate}"),
                    ),

                  const DashedLine(
                      qty: 50, dashWidth: 5.0, dashHeight: 1.0, mrg: 1),
                  //Insurance
                  const Text("Insurance",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.1)),
                  for (AddOnsModel adnMm in avlbInsurance)
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                adnMm.name,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: Icon(
                                      adnMm.isChosen ? Icons.check : Icons.add,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      insuranceNotifier
                                          .toggleInsurScheme(adnMm);
                                      setState(() {
                                        _insuranceOptions = !_insuranceOptions;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adnMm.subTitle!,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 17.1),
                          ),
                          Text(adnMm.more!),
                        ],
                      ),
                    ),
                  const DashedLine(
                      qty: 50, dashWidth: 5.0, dashHeight: 1.0, mrg: 1),
                  const Text("Bill BreakDown",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.1)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person_outlined,
                            color: Colors.blue,
                          ),
                          Text("${regPassengers.length}"),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("Passenger"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (adult.isNotEmpty)
                              Row(
                                children: [
                                  Text("  • Aduldt ${adult.length} "),
                                  const Spacer(),
                                  const Text("₹1500",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            if (child.isNotEmpty)
                              Row(
                                children: [
                                  Text("  • Child ${child.length} (age 3- 10)"),
                                  const Spacer(),
                                  const Text("₹1000",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                          ],
                        ),
                      ),
                      if (!_transportationOptions)
                        Column(
                          children: [
                            const Text("Transportation",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.1)),
                            for (AddOnsModel adn in avlbTransAddOns)
                              if (adn.isChosen)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(adn.name),
                                        const Spacer(),
                                        Text("₹${adn.currentRate}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      if (!_mealSelectionOptions)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Meal",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.1)),
                            for (AddOnsModel adn in avlbMealsAddOns)
                              if (adn.isChosen)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(adn.name),
                                        const Spacer(),
                                        Text("₹${adn.currentRate}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      if (!_otherRecommendationOptions)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Other Recommendations",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.1)),
                            for (AddOnsModel adn in avlbOtherRec)
                              if (adn.isChosen)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(adn.name),
                                        const Spacer(),
                                        Text("₹${adn.currentRate}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      if (!_insuranceOptions)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Insurance",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.1)),
                            for (AddOnsModel adn in avlbInsurance)
                              if (adn.isChosen)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(adn.name),
                                        const Spacer(),
                                        Text("₹${adn.currentRate}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ],
                                ),
                          ],
                        ),
                    ],
                  ),

                  const DashedLine(
                      qty: 50, dashWidth: 5.0, dashHeight: 1.0, mrg: 1),
                  Row(
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.1),
                      ),
                      const Text("(taxes included)"),
                      const Spacer(),
                      Text(
                        "$totAmountProv",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.1),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.5),
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15))),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Finalization(),
                            ));
                      },
                      child: const Text("Proceed"),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
