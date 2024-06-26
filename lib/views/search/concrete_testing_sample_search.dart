import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/data/table/concrete_sample_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_icon_button.dart';

import 'package:masa_epico_concrete_manager/service/concrete_sample_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../../elements/value_notifier_list.dart';
import '../../filters/composite_filter.dart';
import '../../filters/filter_criteria.dart';
import '../../models/concrete_sample.dart';
import '../../models/building_site.dart';

class ConcreteTestingSampleSearch extends StatefulWidget {
  const ConcreteTestingSampleSearch({super.key});

  @override
  State<ConcreteTestingSampleSearch> createState() =>
      _ConcreteTestingSampleSearchState();
}

class _ConcreteTestingSampleSearchState
    extends State<ConcreteTestingSampleSearch> {
  final ValueNotifierList<ConcreteSample>
      concreteTestingSampleNotifier = ValueNotifierList([]);

  final BuildingSiteDAO buildingSiteDao = BuildingSiteDAO();
  final ConcreteSampleDAO concreteTestingSampleDao =
      ConcreteSampleDAO();

  BuildingSite? selectedBuildingSite;
  String? selectedDesignResistance;
  String? selectedDesignAge;

  List<BuildingSite> buildingSites = [];
  List<ConcreteSample> concreteTestingSamples = [];
  List<String> selectionBuildingSites = [];

  bool isTablet = true;

  final TextEditingController _buildingSiteController = TextEditingController();

  late AutoCompleteElement _autoCompleteElement;
  late DropdownButtonFormField _resistanceDropdown;
  late DropdownButtonFormField _ageDropdown;
  late CustomIconButton _clearButton;
  late CustomIconButton _searchButton;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    concreteTestingSampleDao.findAll().then((value) {
      concreteTestingSamples = value;
      concreteTestingSampleNotifier.set(value);
    });

    buildingSiteDao.findAll().then((value) {
      buildingSites = value;
      setState(() {
        selectionBuildingSites = value
            .map((e) =>
                SequentialFormatter.generateSequentialFormatFromBuildingSite(e))
            .toList();
      });
    });
  }

  List<DropdownMenuItem<String>> getDropdownItems(List<String> dropdownItems) {
    return dropdownItems
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context);

    // Determine if the device is a tablet
    isTablet = ScreenUtil().screenWidth > 600;

    _autoCompleteElement = AutoCompleteElement(
      options: selectionBuildingSites,
      onChanged: (selected) => setBuildingSite(selected),
      controller: _buildingSiteController,
      fieldName: "Obra",
    );

    _clearButton = CustomIconButton(
      buttonColor: Colors.grey.shade800,
      icon: Icons.cleaning_services_rounded,
      onPressed: () {
        setState(() {
          selectedBuildingSite = null;
          selectedDesignResistance = null;
          selectedDesignAge = null;
        });
        _autoCompleteElement.controller.clear(); // Clear the text field
        filter(); // Apply filter with cleared fields
      },
    );

    // Inside build method, update the DropdownButtonFormField definitions:
    _resistanceDropdown = DropdownButtonFormField<String>(
      value: selectedDesignResistance,
      items: getDropdownItems(Constants.CONCRETE_COMPRESSION_RESISTANCES),
      onChanged: (String? value) {
        setState(() {
          selectedDesignResistance = value;
        });
      },
      decoration: InputDecoration(
        labelText: "Resistencia de diseño (F'C)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      dropdownColor: Colors.white,
    );

    _ageDropdown = DropdownButtonFormField<String>(
      value: selectedDesignAge,
      items: getDropdownItems(Constants.CONCRETE_DESIGN_AGES),
      onChanged: (String? value) {
        setState(() {
          selectedDesignAge = value;
        });
      },
      decoration: InputDecoration(
        labelText: "Edad de diseño (días)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      dropdownColor: Colors.white,
    );

    _searchButton = CustomIconButton(
      icon: Icons.search,
      onPressed: () => filter(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (isTablet)
          Row(
            children: [
              Expanded(flex: 3, child: _autoCompleteElement),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: _resistanceDropdown),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: _ageDropdown),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _clearButton),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _searchButton),
            ],
          ),
        if (!isTablet)
          Column(
            children: [
              _autoCompleteElement,
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(flex: 3, child: _resistanceDropdown),
                  Expanded(flex: 1, child: _clearButton),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(flex: 3, child: _ageDropdown),
                  Expanded(flex: 1, child: _searchButton),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ConcreteSamplesDataTable(
                concreteTestingSampleNotifier:
                    concreteTestingSampleNotifier,
                rowsPerPage: isTablet ? 8 : 7,
              ),
            ),
          ],
        )
      ],
    );
  }

  void setBuildingSite(String selected) {
    _buildingSiteController.text = selected;
    selectedBuildingSite = buildingSites.firstWhere((element) =>
        element.id == SequentialFormatter.getIdNumberFromConsecutive(selected));
  }

  void filter() {
    final criteria = CompositeFilter([
      BuildingSiteCriteria(selectedBuildingSite),
      DesignResistanceCriteria(selectedDesignResistance),
      DesignAgeCriteria(selectedDesignAge),
    ]);

    concreteTestingSampleNotifier.set(concreteTestingSamples
        .where((element) => criteria.matches(element))
        .toList());
  }
}
