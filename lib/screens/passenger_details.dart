import 'package:book_wave/models/boat_service.dart';
import 'package:book_wave/models/passenger_model.dart';
import 'package:book_wave/providers/addon_provider.dart';
import 'package:book_wave/providers/dummy_provider.dart';
import 'package:book_wave/providers/passenger_register.dart';
import 'package:book_wave/screens/add_ons.dart';
import 'package:book_wave/widgets/src_destin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PassengerDetails extends ConsumerStatefulWidget {
  const PassengerDetails({super.key});
  @override
  ConsumerState<PassengerDetails> createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends ConsumerState<PassengerDetails> {
  final List<TextEditingController> _nameControllersList = [];
  final List<TextEditingController> _ageControllersList = [];
  final List<String?> _selectedGendersList = [];

  final List<GlobalKey<FormState>> _formKeysList = [];
  final List<Passenger> _passengersList = [];

  var _enteredName = '';
  var _enteredAge = '';
  var _enteredGender = '';
  String? _selectedGender;

  int noOfPass = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formKeysList.add(GlobalKey<FormState>());
    _nameControllersList.add(TextEditingController());
    _ageControllersList.add(TextEditingController());
    _selectedGendersList.add(null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (TextEditingController controller in _nameControllersList) {
      controller.dispose();
    }
    for (TextEditingController controller in _ageControllersList) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("widgeting");

    void reseting() {
      ref.read(passengerProvider.notifier).reset();
      _nameControllersList.clear();
      _ageControllersList.clear();
      _selectedGendersList.clear();
      _formKeysList.clear();
      _passengersList.clear();
      print("all clear");
    }

    ///////
    ///////
    ///////
    Widget passenger(int ind) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKeysList[ind],
              child: Column(
                children: [
                  //Inputting Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enter Full Name"),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(7),
                            right: Radius.circular(7),
                          ),
                        ),
                        child: TextFormField(
                          controller: _nameControllersList[ind],
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            hintText: "  Enter your name",
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _enteredName = newValue!;
                          },
                        ),
                      ),
                      const Text("Enter as per Aadhar",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 18),

                  //Inputting Age and Gender
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Enter your age"),
                            Container(
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0),
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(7),
                                  right: Radius.circular(7),
                                ),
                              ),
                              child: TextFormField(
                                controller: _ageControllersList[ind],
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: "Enter your age",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  _enteredAge = newValue!;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Gender"),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 0),
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(7),
                                  right: Radius.circular(7),
                                ),
                              ),
                              child: DropdownButtonFormField(
                                value: _selectedGendersList[ind],
                                hint: const Text("Gender"),
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                items: <String>[' Male', ' Female']
                                    .map(
                                      (g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(g),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) => setState(
                                  () {
                                    _selectedGendersList[ind] = value!;
                                  },
                                ),
                                validator: (value) =>
                                    value == null || value == "Gender"
                                        ? 'Please select a gender'
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(),
          ],
        ),
      );
    }

    final dumData = ref.watch(dummyProvider);
    final dumMealNotifier = ref.read(dummyMealsProvider.notifier);
    return PopScope(
      canPop: true,
      
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          reseting();
          debugPrint("popped from passenger details screen");
        }
      },
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 158, 192, 251)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 45,
                    left: 20,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white54,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back,
                          size: 24, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
                  child: Column(
                    children: [
                      const SrcDestin(),
                      Card(
                        color: const Color.fromARGB(255, 243, 126, 126),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                "Your ticket information will be sent on this number",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.person, color: Colors.white),
                                      Text(
                                        "91911234589",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Passenger Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20),
                                ),
                              ),
                              for (int i = 0; i < noOfPass; i++) passenger(i),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (noOfPass > 1)
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            noOfPass--;
                                            _formKeysList.removeLast();
                                            _nameControllersList.removeLast();
                                            _ageControllersList.removeLast();
                                            _selectedGendersList.removeLast();
                                          });
                                        },
                                        child: const Text("Delete")),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        noOfPass++;
                                        _formKeysList
                                            .add(GlobalKey<FormState>());
                                        _nameControllersList
                                            .add(TextEditingController());
                                        _ageControllersList
                                            .add(TextEditingController());
                                        _selectedGendersList.add(null);
                                      });
                                    },
                                    child: const Text(
                                      "Add Passenger",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: 40),

                      //Submiting the details
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
                            int i = 0;
                            for (GlobalKey<FormState> fm in _formKeysList) {
                              if (fm.currentState!.validate()) {
                                fm.currentState!.save();
                                print("Form saved");
                                _passengersList.add(Passenger(
                                  name: _nameControllersList[i].text,
                                  age: _ageControllersList[i].text,
                                  gender: _selectedGendersList[i]!,
                                ));
                                i++;
                              } else {
                                print("Form is not valid");
                              }
                            }
                            ref.read(passengerProvider.notifier).reset();
                            ref
                                .read(passengerProvider.notifier)
                                .loadPassengerData(_passengersList);
                            print("passenger data loaded");

                            print("searching");
                            for (BoatService brc in dumData) {
                              if (brc.isSelected) {
                                dumMealNotifier.loadData();
                                print("data loaded");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AddOnsScreen(),
                                  ),
                                );
                                return;
                              }
                            }
                            ref.read(mealsProvider.notifier).loadData();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddOnsScreen(),
                              ),
                            );
                            print("data loaded");
                          },
                          label: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
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
