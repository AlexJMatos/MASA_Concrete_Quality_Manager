import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/table/building_site_data_table.dart';
import 'package:masa_epico_concrete_manager/data/table/site_resident_data_table.dart';
import 'package:masa_epico_concrete_manager/data/table/testing_order_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/value_notifier_list.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

import '../data/table/customer_data_table.dart';
import '../models/customer.dart';

class ConcreteQualitySearch extends StatefulWidget {
  const ConcreteQualitySearch({super.key});

  @override
  State<ConcreteQualitySearch> createState() => _ConcreteQualitySearchState();
}

class _ConcreteQualitySearchState extends State<ConcreteQualitySearch> {
  Entity _selected = Entity.Clientes; // Default selected entity
  CustomerDao customerDao = CustomerDao(); // DAO for customers
  BuildingSiteDao projectSiteDao = BuildingSiteDao(); // DAO for project sites
  SiteResidentDao siteResidentDao = SiteResidentDao(); // DAO for site residents
  ConcreteTestingOrderDao concreteTestingOrderDao = ConcreteTestingOrderDao(); // DAO for concrete testing orders

  final ValueNotifierList<Customer> _customersNotifier = ValueNotifierList([]); // Notifier for customers
  final ValueNotifierList<BuildingSite> _buildingSitesNotifier = ValueNotifierList([]);  // Notifier for project sites
  final ValueNotifierList<SiteResident> _siteResidentsNotifier = ValueNotifierList([]);  // Notifier for site residents
  final ValueNotifierList<ConcreteTestingOrder> _concreteTestingOrderNotifier = ValueNotifierList([]);  // Notifier for concrete testing orders

  @override
  void initState() {
    super.initState();
    _loadDataTables(); // Load data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropdownFormField(
                labelText: "Registro",
                items: Entity.values.asNameMap().keys.toList(),
                onChanged: (p0) {
                  setState(() {
                    _selected = Entity.values.byName(p0); // Update the selected entity
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (_selected == Entity.Clientes)
                generateCustomerDataTable()
              else if (_selected == Entity.Obras)
                generateProjectSiteDataTable()
              else if (_selected == Entity.Residentes)
                  generateSiteResidentDataTable()
                else if (_selected == Entity.Muestras)
                    generateConcreteTestingDataTable()
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to generate Customer Data Table
  CustomerDataTable generateCustomerDataTable() {
    return CustomerDataTable(
      customersNotifier: _customersNotifier,
    );
  }

  // Helper method to generate Project Site Data Table
  ProjectSiteDataTable generateProjectSiteDataTable() {
    return ProjectSiteDataTable(
      projectSitesNotifier: _buildingSitesNotifier,
    );
  }

  // Helper method to generate Site Resident Data Table
  SiteResidentDataTable generateSiteResidentDataTable() {
    return SiteResidentDataTable(
      siteResidentNotifier: _siteResidentsNotifier,
    );
  }

  // Helper method to generate Concrete Testing Data Table
  ConcreteTestingDataTable generateConcreteTestingDataTable() {
    return ConcreteTestingDataTable(
      concreteTestingOrdersNotifier: _concreteTestingOrderNotifier,
    );
  }

  // Method to load data for all tables
  void _loadDataTables() {
    customerDao.findAll().then(
          (value) {
        setState(
              () {
            _customersNotifier.value = value; // Update customers notifier
          },
        );
      },
    );

    projectSiteDao.findAll().then(
          (value) {
        setState(
              () {
            _buildingSitesNotifier.value = value; // Update project sites notifier
          },
        );
      },
    );

    siteResidentDao.findAll().then(
          (value) {
        setState(() {
          _siteResidentsNotifier.value = value; // Update site residents notifier
        });
      },
    );

    concreteTestingOrderDao.findAll().then(
          (value) {
        setState(() {
          _concreteTestingOrderNotifier.value = value; // Update concrete testing orders notifier
        });
      },
    );
  }
}

// Enum to define different entities
enum Entity {
  Clientes,
  Obras,
  Residentes,
  Muestras;
}