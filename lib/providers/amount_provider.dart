import 'package:book_wave/providers/addon_provider.dart';
import 'package:book_wave/providers/passenger_register.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmountProvider extends StateNotifier<int?> {
  AmountProvider(this.ref) : super(null) {
    // Automatically update the total whenever the relevant providers change
    ref.listen(transportationProvider, (_, __) => addAmount());
    ref.listen(mealsProvider, (_, __) => addAmount());
    ref.listen(otherRecommsProvider, (_, __) => addAmount());
    ref.listen(insuranceProvider, (_, __) => addAmount());
    ref.listen(passengerProvider, (_, __) => addAmount());
    // Initial amount calculation
    addAmount();
  }

  final Ref ref;

  void addAmount() {
    // Get the list of passengers from the passengerProvider
    final passengers = ref.read(passengerProvider);

    // Calculate the total amount for passengers based on their age
    final passengerTotal = passengers.fold<int>(0, (sum, passenger) {
      int rate = int.parse(passenger.age) < 10 ? 1000 : 1500;
      return sum + rate;
    });

    // Get all chosen transportation items and sum their rates
    final trnsTotal = ref
        .read(transportationProvider)
        .where((element) => element.isChosen)
        .fold(0, (sum, item) => sum + item.currentRate);

    // Get the total amount for meals (rate multiplied by count)
    final mealsTotal = ref
        .read(mealsProvider)
        .fold(0, (sum, meal) => sum + (meal.count * meal.currentRate));

    // Get all chosen other recommendations items and sum their rates
    final otherTotal = ref
        .read(otherRecommsProvider)
        .where((element) => element.isChosen)
        .fold(0, (sum, item) => sum + item.currentRate);

    // Get all chosen insurance items and sum their rates
    final insrTotal = ref
        .read(insuranceProvider)
        .where((element) => element.isChosen)
        .fold(0, (sum, item) => sum + item.currentRate);

    // Calculate the total amount for one passenger
    final totalForOne = trnsTotal + mealsTotal + otherTotal + insrTotal;

    // Calculate the total amount for all passengers and selected add-ons
    state = totalForOne + passengerTotal;
  }
}

final totalProvider = StateNotifierProvider<AmountProvider, int?>(
  (ref) => AmountProvider(ref),
);
