import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rylax_admin/core/network/models/valuation/req/rylax_property_valuation_request.dart';
import 'package:rylax_admin/core/network/models/valuation/res/rylax_valuation_response.dart';
import 'package:rylax_admin/core/services/navigation_service.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_form_submit_button.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
import 'package:rylax_admin/core/widgets/app_text_input_with_title.dart';

import '../../core/widgets/energy_rating_drop_down_menu.dart';
import '../../core/widgets/finish_level_drop_down_menu.dart';
import '../developments/presentation/widgets/int_drop_down_menu.dart';
import '../developments/presentation/widgets/property_style_drop_down.dart';

class ValuationTool extends StatefulWidget {
  const ValuationTool({super.key});

  @override
  State<ValuationTool> createState() => _ValuationToolState();
}

class _ValuationToolState extends State<ValuationTool> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();
  final NavigationService navigationService = NavigationService();
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _bedsCtrl = TextEditingController();
  final _bathsCtrl = TextEditingController();
  final _locationTownCtrl = TextEditingController();
  final _locationCountyCtrl = TextEditingController();
  final _featuresCtrl = TextEditingController();
  final _sqmCtrl = TextEditingController();
  final _buildYearCtrl = TextEditingController();
  final _plotSizeCtrl = TextEditingController();

  bool bedsValidatedFailed = false;
  bool bathsValidatedFailed = false;
  bool sqmValidatedFailed = false;
  bool plotSizeValidatedFailed = false;
  bool energyRatingValidatedFailed = false;
  bool buildYearValidated = false;
  bool propertyStyleValidatedFailed = false;
  bool finishLevelValidatedFailed = false;
  bool locationTownValidatedFailed = false;
  bool locationCountyValidatedFailed = false;

  int? _bedsCount;
  int? _bathsCount;

  // Dropdown values
  String? _energyRating; // A1..G
  String? _finishLevel;
  String? _styleSelected;

  @override
  void dispose() {
    _bedsCtrl.dispose();
    _bathsCtrl.dispose();
    _locationTownCtrl.dispose();
    _locationCountyCtrl.dispose();
    _featuresCtrl.dispose();
    _sqmCtrl.dispose();
    _buildYearCtrl.dispose();
    _plotSizeCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    var valuationRequest = RylaxPropertyValuationRequest();
    valuationRequest.beds = _bedsCount!;
    valuationRequest.baths = _bathsCount!;
    valuationRequest.locationTown = _locationTownCtrl.text;
    valuationRequest.locationCounty = _locationCountyCtrl.text;
    valuationRequest.energyRating = _energyRating!;
    valuationRequest.sqm = double.tryParse(_sqmCtrl.text)!;
    valuationRequest.propertyStyle = _styleSelected!;
    valuationRequest.approxBuildYear = int.tryParse(_buildYearCtrl.text)!;
    valuationRequest.plotSize = double.tryParse(_plotSizeCtrl.text)!;
    valuationRequest.finishLevel = _finishLevel!;
    valuationRequest.features = _featuresCtrl.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

    Future<RylaxValuationResponse> response = rylaxAPIService.getValuationReport(valuationRequest);
    navigationService.navigateToValuationView(context, response);
    print("valuation report: $response");
  }

  InputDecoration _dec(String label, {String? hint, String? suffix}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixText: suffix,
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(textValue: "Valuation Tool", fontSize: 24, fontWeight: FontWeight.bold),
                AppText(textValue: "Rough Working Proto-type, All Fields are required.", fontSize: 12, fontWeight: FontWeight.bold),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextInputWithTitle(
                        inputFailedValidation: locationTownValidatedFailed,
                        textEditingController: _locationTownCtrl,
                        validationFailedMessage: 'Please enter a valid location',
                        title: 'Location',
                        hint: 'eg. Pebble Bay, Wicklow Town / Enniscorthy / Or just the road and location town',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextInputWithTitle(
                        inputFailedValidation: locationCountyValidatedFailed,
                        textEditingController: _locationCountyCtrl,
                        validationFailedMessage: 'Please enter a valid location',
                        title: 'County',
                        hint: 'eg. Co. Wicklow / Co. Dublin etc.',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: IntDropDownMenu(
                        inputFailedValidation: bedsValidatedFailed,
                        label: 'Beds',
                        selectedNumber: _bedsCount,
                        required: true,
                        onChanged: (n) => setState(() => _bedsCount = n),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: IntDropDownMenu(
                        inputFailedValidation: bathsValidatedFailed,
                        label: 'Baths',
                        selectedNumber: _bathsCount,
                        required: true,
                        onChanged: (n) => setState(() => _bathsCount = n),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: EnergyRatingDropDownMenu(
                        label: 'Energy Rating (BER)',
                        selectedRating: _energyRating,
                        required: true,
                        inputFailedValidation: energyRatingValidatedFailed,
                        validationFailedMessage: 'Select a BER rating',
                        onChanged: (v) => setState(() => _energyRating = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextInputWithTitle(
                        inputFailedValidation: sqmValidatedFailed,
                        textEditingController: _sqmCtrl,
                        validationFailedMessage: 'Please enter a valid SQM',
                        title: 'Sqm',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: AppTextInputWithTitle(
                        inputFailedValidation: plotSizeValidatedFailed,
                        textEditingController: _plotSizeCtrl,
                        validationFailedMessage: 'Please enter a valid plot size',
                        hint: '0.1 (.1 of Acre) 1.0 (acre)',
                        title: 'Plot Size',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: AppTextInputWithTitle(
                        inputFailedValidation: buildYearValidated,
                        textEditingController: _buildYearCtrl,
                        validationFailedMessage: 'Please enter a valid plot size',
                        hint: 'eg. 2001, 2007',
                        title: 'Build Year',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: PropertyStyleDropdown(
                        inputFailedValidation: propertyStyleValidatedFailed,
                        label: 'Property Style',
                        selectedValue: _styleSelected,
                        required: true,
                        onChanged: (style) => setState(() => _styleSelected = style),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FinishLevelDropDownMenu(
                        label: 'Finish Level',
                        selectedFinishLevel: _finishLevel,
                        // String?
                        required: true,
                        inputFailedValidation: finishLevelValidatedFailed,
                        // bool
                        validationFailedMessage: 'Select a finish level',
                        onChanged: (v) => setState(() => _finishLevel = v!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                // Features (multi-line, comma-separated)
                TextFormField(
                  controller: _featuresCtrl,
                  decoration: _dec('Features', hint: 'Comma-separated (e.g. garden, garage, south-facing)'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),

                Center(
                  child: SizedBox(
                    width: 400,
                    child: AppFormSubmitButton(label: "Submit", function: _submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
