import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rylax_admin/core/network/models/development_dto.dart';
import 'package:rylax_admin/core/network/models/property_dto.dart';
import 'package:rylax_admin/core/services/rylax_api_service.dart';
import 'package:rylax_admin/core/styles/app_text_styles.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/utils/snack_barz.dart';
import 'package:rylax_admin/core/utils/font_size_utils.dart';
import 'package:rylax_admin/core/widgets/app_icon_button.dart';
import 'package:rylax_admin/core/widgets/app_text.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/create_development_phase_dialog.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/create_property_dialog.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/property_table_columns.dart';

class DevelopmentView extends StatefulWidget {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();
  final int developmentId;

  DevelopmentView({super.key, required this.developmentId});

  @override
  State<DevelopmentView> createState() => _DevelopmentViewState();
}

class _DevelopmentViewState extends State<DevelopmentView> {
  late Future<DevelopmentDTO> _future;
  PlutoGridStateManager? _stateManager;

  // Label maps (unchanged)
  static const buildSaleStatusLabels = {
    'AWAITING_INSTRUCTION': 'Awaiting Instruction',
    'INSTRUCTED': 'Instructed',
    'LISTED': 'Listed',
    'RESERVED': 'Reserved',
    'BOOKING_DEPOSIT_RECEIVED': 'Booking Deposit Received',
    'CONTRACTS_ISSUED': 'Contracts Issued',
    'SNAGGING': 'Snagging',
    'SNAGGED': 'Snagged',
    'SNAGS_COMPLETED': 'Snags Completed',
    'COMPLETE': 'Complete',
  };
  final Map<String, String> saleStatusLabelToKey = buildSaleStatusLabels.map((k, v) => MapEntry(v, k));

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
  final Map<String, String> buildStatusLabelToKey = buildStatusLabels.map((k, v) => MapEntry(v, k));

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
  void initState() {
    super.initState();
    _future = _fetch();
  }

  Future<DevelopmentDTO> _fetch() async {
    return await widget.rylaxAPIService.getDevelopmentById(widget.developmentId);
  }

  void _refresh() {
    print("state-refresh");
    setState(() {
        _future = _fetch();
    });
  }

  void _showCreateDevelopmentPhaseDialog(BuildContext context, DevelopmentDTO dto) {
    showDialog(
      context: context,
      builder: (_) => CreateDevelopmentPhaseDialog(developmentDTO: dto),
    ); // refresh after closing
  }

  void _showCreatePropertyDialog(BuildContext context, DevelopmentDTO dto) {
    showDialog(
      context: context,
      builder: (_) => CreatePropertyDialog(developmentDTO: dto, refreshDevelopmentViewState: _refresh),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headingSize = FontSizeUtils.determineHeadingSize(context);
    final subtitleSize = FontSizeUtils.determineSubtitleSize(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder<DevelopmentDTO>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load development'),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: _refresh, child: const Text('Retry')),
                ],
              ),
            );
          }

          final dto = snap.data!;
          final columns = PropertyTableColumns().getDefaultColumns(context);
          final rowKeyToProperty = <Key, PropertyDTO>{};
          final rows = _extractRows(dto, rowKeyToProperty);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(textValue: dto.developmentName, fontSize: headingSize),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    AppText(textValue: "Phases: ${dto.developmentPhases.length}", fontSize: subtitleSize),
                    const SizedBox(width: 20),
                    AppText(textValue: "Properties: ${rows.length}", fontSize: subtitleSize),
                    const SizedBox(width: 20),
                    AppText(textValue: "Buyers: 14", fontSize: subtitleSize),
                    const SizedBox(width: 20),
                    AppText(textValue: "Verified Buyers: 9", fontSize: subtitleSize),
                    const SizedBox(width: 20),
                    AppText(textValue: "Status: Active", fontSize: subtitleSize),
                    const Spacer(),
                    IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    AppIconButton(icon: Icons.add, label: "Add Phase", onPressed: () => _showCreateDevelopmentPhaseDialog(context, dto)),
                    const SizedBox(width: 20),
                    AppIconButton(icon: Icons.add, label: "Add Property", onPressed: () => _showCreatePropertyDialog(context, dto)),
                    const SizedBox(width: 20),
                    AppIconButton(
                      icon: Icons.add_chart,
                      label: "View Snags",
                      foregroundColor: AppColors.mainGreen,
                      backgroundColor: AppColors.mainWhite,
                      onPressed: () {}, // TODO
                    ),
                    const SizedBox(width: 20),
                    AppIconButton(
                      icon: Icons.upload,
                      label: "Upload File",
                      foregroundColor: AppColors.mainGreen,
                      backgroundColor: AppColors.mainWhite,
                      onPressed: () {}, // TODO
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
                        columns: columns,
                        rows: rows,
                        onLoaded: (event) => _stateManager = event.stateManager,
                        onChanged: (event) async {
                          final prop = rowKeyToProperty[event.row.key];
                          if (prop == null) return;

                          // optimistic update + rollback on error
                          final previousSale = prop.saleStatus;
                          final previousBuild = prop.buildStatus;

                          try {
                            if (event.column.field == 'saleStatus') {
                              final newStatus = saleStatusLabelToKey[event.value];
                              if (newStatus == null) return;
                              prop.saleStatus = newStatus;
                              await widget.rylaxAPIService.updateProperty(prop);
                              SnackBarz.showSnackBar(context, AppColors.mainGreen, "Sale Status Changed");
                            } else if (event.column.field == 'buildStatus') {
                              final newStatus = buildStatusLabelToKey[event.value];
                              if (newStatus == null) return;
                              prop.buildStatus = newStatus;
                              await widget.rylaxAPIService.updateProperty(prop);
                              SnackBarz.showSnackBar(context, AppColors.mainGreen, "Build Status Changed");
                            }
                          } catch (_) {
                            // rollback local change
                            prop
                              ..saleStatus = previousSale
                              ..buildStatus = previousBuild;
                            SnackBarz.showSnackBar(context, Colors.red, "Failed to update");
                            _refresh(); // reload truth from server
                          }
                        },
                        configuration: PlutoGridConfiguration(
                          style: PlutoGridStyleConfig(
                            cellTextStyle: AppTextStyles.defaultFontStyle(18),
                            columnTextStyle: AppTextStyles.defaultFontStyle(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<PlutoRow> _extractRows(DevelopmentDTO dto, Map<Key, PropertyDTO> rowKeyToProperty) {
    final out = <PlutoRow>[];
    for (final phase in dto.developmentPhases) {
      for (final property in phase.properties) {
        final rowKey = ValueKey(property.id);
        rowKeyToProperty[rowKey] = property;

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
              'createdDate': PlutoCell(value: property.createdDate),
              'actions': PlutoCell(value: "Todo"),
            },
          ),
        );
      }
    }
    return out;
  }
}
