// Interface for filter criteria
import '../models/building_site.dart';
import '../models/concrete_testing_sample.dart';

abstract class FilterCriteria {
  bool matches(ConcreteTestingSample element);
}

// Concrete implementations for each criterion
class BuildingSiteCriteria implements FilterCriteria {
  final BuildingSite? selectedBuildingSite;

  BuildingSiteCriteria(this.selectedBuildingSite);

  @override
  bool matches(ConcreteTestingSample element) {
    return selectedBuildingSite == null ||
        element.concreteTestingOrder.buildingSite.id ==
            selectedBuildingSite?.id;
  }
}

class DesignResistanceCriteria implements FilterCriteria {
  final String? selectedDesignResistance;

  DesignResistanceCriteria(this.selectedDesignResistance);

  @override
  bool matches(ConcreteTestingSample element) {
    return selectedDesignResistance == null ||
        element.concreteTestingOrder.designResistance ==
            selectedDesignResistance;
  }
}

class DesignAgeCriteria implements FilterCriteria {
  final String? selectedDesignAge;

  DesignAgeCriteria(this.selectedDesignAge);

  @override
  bool matches(ConcreteTestingSample element) {
    return selectedDesignAge == null ||
        element.concreteTestingOrder.designAge == selectedDesignAge;
  }
}
