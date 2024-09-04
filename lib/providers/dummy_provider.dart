import 'package:book_wave/data/dummy_data.dart';
import 'package:book_wave/models/addon_model.dart';
import 'package:book_wave/models/boat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DummyNotifier extends StateNotifier<List<BoatService>> {
  DummyNotifier() : super(dums);

  void toggleSelectedStatus(BoatService bSrcv) {
    final newStatus = !bSrcv.isSelected;

    state = [
      for (BoatService brc in state)
        if (bSrcv.id == brc.id) brc.copyWith(isSelected: newStatus) else brc
    ];
    print("state changed");
    print("status of ${bSrcv.id} is updated to $newStatus");
  }
}

class DummyMealsProvider extends StateNotifier<List<AddOnsModel>> {
  DummyMealsProvider(this.ref) : super([]);

  final Ref ref;

  void loadData() {
    final d = ref.watch(dummyProvider);

    List<AddOnsModel> mealTemp = [];

    print("going to find the selected boatservice");
    final dataSelected = d.firstWhere(
      (element) => element.isSelected,
      orElse: () => BoatService(
        id: "id",
        serviceName: "serviceName",
        description: "description",
        rate: "rate",
        image: "image",
        avlbSeats: "avlbSeats",
        isSelected: false,
      ),
    );

    print("Added ot the meal temps");
    print(
        "status of ${dataSelected.serviceName} is ${dataSelected.isSelected}");
    if (dataSelected.isSelected) {
      print("found the selected boatService");
      for (String i in dataSelected.meals!) {
        mealTemp.add(AddOnsModel(
          id: "id",
          name: i,
          currentRate: 500,
        ));
        print(i);
      }
      print("found the meal temps : $mealTemp");
      state = mealTemp;
      print(mealTemp[1].name);
      print("data meals of boat service added to state");
    } else {
      // Handle no data selected
      return;
    }
  }

  void toggleMealReq(AddOnsModel ml) {
    final newStatus = !ml.isChosen;
    print(
        'Toggling meal: ${ml.name}, new status: $newStatus, count: ${ml.count}'); // Debug print

    state = [
      for (AddOnsModel adn in state)
        if (adn.id == ml.id) adn.copyWith(isChosen: newStatus) else adn
    ];
  }

  int count = 0;
  void updateMealCount(AddOnsModel mod) {
    print(
        'Updating meal count for id: ${mod.id}, new count: ${mod.count}'); // Debug print

    state = [
      for (AddOnsModel adn in state)
        if (adn.id == mod.id) adn.copyWith(count: adn.count + 1) else adn
    ];
    final updatedMod = state.firstWhere((adn) => adn.id == mod.id);
    print("The count is now: ${updatedMod.isChosen} for ${updatedMod.name}");
  }

  void decrementMealCount(AddOnsModel mod) {
    print(
        'Decrementing meal count for id: ${mod.id}, new count: ${mod.count}'); // Debug print

    state = [
      for (AddOnsModel adn in state)
        if (adn.id == mod.id) adn.copyWith(count: adn.count - 1) else adn
    ];
  }

  void reset() {
    state = [];
  }
}

final dummyProvider = StateNotifierProvider<DummyNotifier, List<BoatService>>(
  (ref) => DummyNotifier(),
);

final dummyMealsProvider =
    StateNotifierProvider<DummyMealsProvider, List<AddOnsModel>>(
  (ref) => DummyMealsProvider(ref),
);
