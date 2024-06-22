import 'package:masa_epico_concrete_manager/models/concrete_testing_remission.dart';

class ConcreteTestingSample {
  int? id;
  int testingAge;
  DateTime testingDate;
  int? totalLoad;
  int? designResistance;
  num? median;
  num? percentage;
  ConcreteTestingRemission concreteTestingRemission;

  ConcreteTestingSample(
      {this.id,
      required this.testingAge,
      required this.testingDate,
      required this.totalLoad,
      required this.designResistance,
      this.median,
      this.percentage,
      required this.concreteTestingRemission});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "testing_age_days": testingAge,
      "testing_date": testingDate.millisecondsSinceEpoch,
      "total_load_kg": totalLoad,
      "resistance_kgf_cm2": designResistance,
      "median": median,
      "percentage": percentage,
      "concrete_testing_remission_id": concreteTestingRemission.id
    };
  }

  ConcreteTestingSample toModel(Map<String, Object?> map) {
    ConcreteTestingRemission concreteTestingRemission =
        ConcreteTestingRemission.toModel(map);

    return ConcreteTestingSample(
        id: map["id"] as int,
        testingAge: map["testing_age_days"] as int,
        testingDate: DateTime.fromMillisecondsSinceEpoch((map["testing_date"] ??
            DateTime.now().millisecondsSinceEpoch) as int),
        totalLoad: map["total_load_kg"] as int?,
        designResistance: map["resistance_kgf_cm2"] as int?,
        median: map["median"] as num?,
        percentage: map["percentage"] as num?,
        concreteTestingRemission: concreteTestingRemission);
  }
}
