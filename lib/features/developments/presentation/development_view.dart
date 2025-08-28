import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_text_styles.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_icon_button.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/create_development_phase_dialog.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/create_property_dialog.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/property_table_columns.dart';

import '../../../core/network/models/property_dto.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/utils/snack_barz.dart';

class DevelopmentView extends StatefulWidget {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();
  final DevelopmentDTO developmentDTO;

  DevelopmentView({super.key, required this.developmentDTO});

  @override
  State<DevelopmentView> createState() => _DevelopmentViewState();
}

class _DevelopmentViewState extends State<DevelopmentView> {
  late final List<PlutoColumn> _columns;
  late final List<PlutoRow> _rows;
  final Map<Key, PropertyDTO> _rowKeyToProperty = {};

  PlutoGridStateManager? _stateManager;

  @override
  void initState() {
    super.initState();
    _columns = PropertyTableColumns().getDefaultColumns(context);
    _rows = _extractRows(widget.developmentDTO);
  }

  void showCreateDevelopmentPhaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateDevelopmentPhaseDialog(developmentDTO: widget.developmentDTO);
      },
    );
  }

  void showCreatePropertyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreatePropertyDialog(developmentDTO: widget.developmentDTO);
      },
    );
  }

  void doNothing() {
    print("doing nothing");
  }

  static const buildSaleStatusLabels = {
    'AWAITING_INSTRUCTION': 'Awaiting Instruction',
    'INSTRUCTED': 'Instructed',
    'LISTED': 'Listed',
    'RESERVED': 'Reserved',
    'BOOKING_DEPOSIT_RECEIVED': 'Booking Deposit Received',
    'CONTRACTS_ISSUED': 'Contracts Issued',
    'SNAGGING': 'Snagging',
    'SNAGGED': 'Snagged',
    'SNAGS_COMPLETE': 'Snags Complete',
    'COMPLETE': 'Complete',
  };

  final Map<String, String> saleStatusLabelToKey = buildSaleStatusLabels.map((key, label) => MapEntry(label, key));

  static const buildStatusLabels = {
    'PLANNING': 'Planning',
    'PRE_CONSTRUCTION': 'Pre Construction',
    'GROUNDWORK_AND_FOUNDATIONS': 'Groundwork and Foundations',
    'STRUCTURAL_BUILD': 'Structural Build',
    'FIRST_FIX_STAGE': 'First Fix Stage',
    'EXTERNAL_FINISHES': 'External Finishes',
    'SECOND_FIX_STAGE': 'Second Fix Stage',
    'INTERNAL_FINISHES': 'Internal Finishes',
    'HANDOVER_STAGE': 'Handover Stage',
    'COMPLETE': 'Complete',
  };

  final Map<String, String> buildStatusLabelToKey = buildStatusLabels.map((key, label) => MapEntry(label, key));

  static const propertyStyleLabels = {
    'END_OF_TERRACE': 'End of Terrace',
    'MID_TERRACE': 'Mid Terrace',
    'SEMI_DETACHED': 'Semi Detached',
    'DETACHED': 'Detached',
    'BUNGALOW': 'Bungalow',
    'GROUND_FLOOR_END_OF_TERRACE': 'Ground Floor End of Terrace',
    'GROUND_FLOOR_MID_TERRACE': 'Ground Floor Mid Terrace',
    'DUPLEX_END_OF_TERRACE': 'Duplex End of Terrace',
    'DUPLEX_MID_TERRACE': 'Duplex Mid Terrace',
  };

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);
    final subtitleSize = FontSizeUtils.determineSubtitleSize(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(textValue: widget.developmentDTO.developmentName, fontSize: headingSize),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                AppText(textValue: "Phases: ${widget.developmentDTO.developmentPhases.length}", fontSize: subtitleSize),
                const SizedBox(width: 20),
                AppText(textValue: "Properties: ${_rows.length}", fontSize: subtitleSize),
                const SizedBox(width: 20),
                AppText(textValue: "Buyers: 14", fontSize: subtitleSize),
                const SizedBox(width: 20),
                AppText(textValue: "Verified Buyers: 9", fontSize: subtitleSize),
                const SizedBox(width: 20),
                AppText(textValue: "Status: Active", fontSize: subtitleSize),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                AppIconButton(icon: Icons.add, label: "Add Phase", onPressed: () => showCreateDevelopmentPhaseDialog(context)),
                const SizedBox(width: 20),
                AppIconButton(icon: Icons.add, label: "Add Property", onPressed: () => showCreatePropertyDialog(context)),
                const SizedBox(width: 20),
                AppIconButton(
                  icon: Icons.add_chart,
                  label: "View Snags",
                  foregroundColor: AppColors.mainGreen,
                  backgroundColor: AppColors.mainWhite,
                  onPressed: () => doNothing(),
                ),
                const SizedBox(width: 20),
                AppIconButton(
                  icon: Icons.upload,
                  label: "Upload File",
                  foregroundColor: AppColors.mainGreen,
                  backgroundColor: AppColors.mainWhite,
                  onPressed: () => doNothing(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Card(
                elevation: 1,
                color: AppColors.mainWhite,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlutoGrid(
                    columns: _columns,
                    rows: _rows,
                    onLoaded: (event) {
                      _stateManager = event.stateManager;
                    },
                    onChanged: (event) async {
                      PropertyDTO? prop = _rowKeyToProperty[event.row.key];
                      if (prop != null) {
                        if (event.column.field == 'saleStatus') {
                          var newStatus = saleStatusLabelToKey[event.value];
                          prop.saleStatus = newStatus!;
                          await widget.rylaxAPIService.updateProperty(prop);
                          SnackBarz.showSnackBar(context, AppColors.mainGreen, "Sale Status Changed");
                        }
                        if (event.column.field == 'buildStatus') {
                          var newStatus = buildStatusLabelToKey[event.value];
                          prop.buildStatus = newStatus!;
                          await widget.rylaxAPIService.updateProperty(prop);
                          SnackBarz.showSnackBar(context, AppColors.mainGreen, "Build Status Changed");
                        }
                      }
                    },
                    configuration: PlutoGridConfiguration(
                      style: PlutoGridStyleConfig(
                        cellTextStyle: AppTextStyles.defaultFontStyle(18),
                        columnTextStyle: AppTextStyles.defaultFontStyle(18),
                      ),
                    ), // defaults: sortable + resizable columns
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PlutoRow> _extractRows(DevelopmentDTO dto) {
    final out = <PlutoRow>[];
    for (final phase in dto.developmentPhases) {
      for (final property in phase.properties) {
        final rowKey = ValueKey(property.id); // stable per property
        _rowKeyToProperty[rowKey] = property;

        out.add(
          PlutoRow(
            key: rowKey,
            cells: {
              'unitType': PlutoCell(value: property.unitType),
              'propertyStyle': PlutoCell(value: propertyStyleLabels[property.propertyStyle] ?? property.propertyStyle),
              'buyerAssigned': PlutoCell(value: property.assignedBuyerId),
              'saleStatus': PlutoCell(value: buildSaleStatusLabels[property.saleStatus] ?? property.saleStatus),
              'buildStatus': PlutoCell(value: buildStatusLabels[property.buildStatus] ?? property.buildStatus),
              'phaseName': PlutoCell(value: phase.phaseName),
              'bedsNumber': PlutoCell(value: property.beds),
              'bathsNumber': PlutoCell(value: property.baths),
              'squareMeters': PlutoCell(value: property.sqm),
              'price': PlutoCell(value: property.price),
              'actions': PlutoCell(value: "Todo"),
            },
          ),
        );
      }
    }
    return out;
  }
}
