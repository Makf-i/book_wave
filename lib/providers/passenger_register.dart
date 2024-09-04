import 'package:book_wave/models/passenger_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PassengerRegister extends StateNotifier<List<Passenger>> {
  PassengerRegister() : super([]);

  void registerData() {}

  void loadPassengerData(List<Passenger> passList) {
    state = [];
    state = passList.map((passenger) {
      // Determine personRate based on age
      int rate = int.parse(passenger.age) < 10 ? 1000 : 1500;
      // Return a new Passenger instance with updated personRate
      return passenger.copyWith(personRate: rate);
    }).toList();
    print(state[0].name);
  }

  bool reset() {
    state = [];
    print("hurray state reseted");
    //print(state[0].name);
    return true;
  }
}

final passengerProvider =
    StateNotifierProvider<PassengerRegister, List<Passenger>>(
  (ref) => PassengerRegister(),
);
