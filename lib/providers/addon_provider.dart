import 'package:book_wave/data/insurance.dart';
import 'package:book_wave/data/other_rec.dart';
import 'package:book_wave/data/transp_addons.dart';
import 'package:book_wave/models/addon_model.dart';
import 'package:book_wave/models/boat_service.dart';
import 'package:book_wave/providers/data_noti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const uid = Uuid();

class TransportationProviderNotifier extends StateNotifier<List<AddOnsModel>> {
  TransportationProviderNotifier() : super(transpAddOnsList);

  void toggleTranspReq(AddOnsModel adnM) {
    final newStatus = !adnM.isChosen;
    state = [
      for (AddOnsModel adn in state)
        if (adn.id == adnM.id) adn.copyWith(isChosen: newStatus) else adn
    ];
  }
}

class MealsProvider extends StateNotifier<List<AddOnsModel>> {
  MealsProvider(this.ref) : super([]);

  final Ref ref;

  void loadData() {
    final boatServices = ref.read(dataManipulator);
    List<AddOnsModel> mealTemp = [];

    print("going to find the selected boatservice");
    final dataSelectedTrue = boatServices.when(
      data: (data) {
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
      error: (error, stackTrace) {},
      loading: () {},
    ); // Get the selected meal data
    final dataSelected = dataSelectedTrue!;
    print("Added ot the meal temps");
    if (dataSelected.isSelected) {
      print("found the selected boatService");
      for (String i in dataSelected.meals!) {
        mealTemp.add(AddOnsModel(
          id: uid.v4(),
          name: i,
          currentRate: 500,
        ));
        print(i);
      }
      print("found the meal temps : $mealTemp");
      state = mealTemp;
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
    print(ml.name);
    print(ml.id);
    print(ml.isChosen);
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

///
class OtherRecommendationNotifier extends StateNotifier<List<AddOnsModel>> {
  OtherRecommendationNotifier()
      : super(
            otherRecommendationList); // Ensure otherRecommendationsList is defined somewhere

  void toggleOtherRecSelection(AddOnsModel adon) {
    final newStatus = !adon.isChosen;

    state = [
      for (AddOnsModel adn in state)
        if (adn.id == adon.id) adn.copyWith(isChosen: newStatus) else adn
    ];
  }
}

class InsuranceNotifier extends StateNotifier<List<AddOnsModel>> {
  InsuranceNotifier() : super(insuranceAddOnsList);

  bool toggleInsurScheme(AddOnsModel adnM) {
    final newStatus = !adnM.isChosen;
    state = [
      for (AddOnsModel adn in state)
        if (adn.id == adnM.id) adn.copyWith(isChosen: newStatus) else adn
    ];
    if (newStatus) {
      return true;
    } else {
      return false;
    }
  }
}

final transportationProvider =
    StateNotifierProvider<TransportationProviderNotifier, List<AddOnsModel>>(
  (ref) => TransportationProviderNotifier(),
);

final mealsProvider = StateNotifierProvider<MealsProvider, List<AddOnsModel>>(
  (ref) => MealsProvider(ref),
);

final otherRecommsProvider =
    StateNotifierProvider<OtherRecommendationNotifier, List<AddOnsModel>>(
        (ref) => OtherRecommendationNotifier());

final insuranceProvider =
    StateNotifierProvider<InsuranceNotifier, List<AddOnsModel>>(
  (ref) => InsuranceNotifier(),
);
