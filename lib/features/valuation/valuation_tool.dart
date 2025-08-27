import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';

class ValuationTool extends StatefulWidget {
  const ValuationTool({super.key});

  @override
  State<ValuationTool> createState() => _ValuationToolState();
}

class _ValuationToolState extends State<ValuationTool> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _bedsCtrl = TextEditingController();
  final _bathsCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _featuresCtrl = TextEditingController();
  final _sqmCtrl = TextEditingController();
  final _buildYearCtrl = TextEditingController();
  final _plotSizeCtrl = TextEditingController();

  // Dropdown values
  String? _energyRating; // A1..G
  String _finishLevel = 'Standard';

  final _energyRatings = const [
    'A1','A2','A3','B1','B2','B3','C1','C2','C3','D1','D2','E1','E2','F','G'
  ];
  final _finishLevels = const ['Basic', 'Standard', 'Premium'];

  @override
  void dispose() {
    _bedsCtrl.dispose();
    _bathsCtrl.dispose();
    _locationCtrl.dispose();
    _featuresCtrl.dispose();
    _sqmCtrl.dispose();
    _buildYearCtrl.dispose();
    _plotSizeCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'beds': int.tryParse(_bedsCtrl.text),
      'baths': int.tryParse(_bathsCtrl.text),
      'location': _locationCtrl.text.trim(),
      'features': _featuresCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(),
      'energyRating': _energyRating,
      'squareMeters': double.tryParse(_sqmCtrl.text),
      'approxBuildYear': int.tryParse(_buildYearCtrl.text),
      'plotSizeSqm': double.tryParse(_plotSizeCtrl.text),
      'finishLevel': _finishLevel,
    };

    // TODO: Replace with your actual submission logic / bloc / provider call.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Submitted! $payload')),
    );
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
      appBar: AppBar(
        title: const Text("Valuation Tool"),
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  textValue: "Valuation Tool",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),

                // Beds / Baths
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _bedsCtrl,
                        decoration: _dec('Beds'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _bathsCtrl,
                        decoration: _dec('Baths'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Location
                TextFormField(
                  controller: _locationCtrl,
                  decoration: _dec('Location', hint: 'e.g. Rathnew, Co. Wicklow'),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Features (multi-line, comma-separated)
                TextFormField(
                  controller: _featuresCtrl,
                  decoration: _dec('Features',
                      hint: 'Comma-separated (e.g. garden, garage, south-facing)'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),

                // Energy Rating
                DropdownButtonFormField<String>(
                  value: _energyRating,
                  items: _energyRatings
                      .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                      .toList(),
                  onChanged: (v) => setState(() => _energyRating = v),
                  decoration: _dec('Energy Rating (BER)'),
                  validator: (v) => v == null ? 'Select a rating' : null,
                ),
                const SizedBox(height: 12),

                // Square meters & Plot size
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _sqmCtrl,
                        decoration: _dec('Square Meters', suffix: 'm²'),
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _plotSizeCtrl,
                        decoration: _dec('Plot Size', suffix: 'm²'),
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Approx Build Year & Finish Level
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _buildYearCtrl,
                        decoration: _dec('Approx. Build Year', hint: 'e.g. 1998'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _finishLevel,
                        items: _finishLevels
                            .map((r) =>
                            DropdownMenuItem(value: r, child: Text(r)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _finishLevel = v ?? _finishLevel),
                        decoration: _dec('Finish Level'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
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
