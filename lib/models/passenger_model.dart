import 'package:book_wave/models/addon_model.dart';

class Passenger {
  final String name;
  final String age;
  final String gender;
  final List<AddOnsModel>? chosens;
  final int? personRate;

  Passenger copyWith({
    String? name,
    String? age,
    String? gender,
    List<AddOnsModel>? chosens,
    int? personRate,
  }) {
    return Passenger(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      chosens: chosens ?? this.chosens,
      personRate: personRate ?? this.personRate,
    );
  }

  const Passenger({
    required this.name,
    required this.age,
    required this.gender,
    this.chosens,
    this.personRate,
  });
}
