import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rylax_admin/core/styles/app_colors.dart';
import 'package:rylax_admin/core/styles/app_text_styles.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/assign_buyer_button.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/buyer_assignement_selection.dart';
import 'package:rylax_admin/features/developments/presentation/widgets/property_view_dialog.dart';

import '../../../../core/utils/snack_barz.dart';

class PropertyTableColumns {
  PlutoGridStateManager? _stateManager;

  static const kBuildStatuses = <String>[
    'Planning',
    'Pre Construction',
    'Groundwork and Foundations',
    'Structural Build',
    'First Fix',
    'External Finishes',
    'Second Fix',
    'Internal Finishes',
    'Handover Stage',
    'Complete',
  ];
  static const kSaleStatuses = <String>[
    'Awaiting Instruction',
    'Instructed',
    'Listed',
    'Reserved',
    'Booking Deposit Received',
    'Contracts Issued',
    'Snagging',
    'Snagged',
    'Snags Completed',
    'Complete',
  ];

  void doNothing() {}

  void _onOpen(PlutoRow row) {
    final phaseName = row.cells['phaseName']?.value;
    final phaseNumber = row.cells['phaseNumber']?.value;
    // TODO: navigate to details page
    debugPrint('Open -> $phaseName #$phaseNumber');
  }

  void _onEdit(PlutoRow row) async {
    // TODO: show edit dialog or route
    debugPrint('Edit -> ${row.cells['propertyType']?.value}');
  }

  void _onUpload(PlutoRow row) async {
    // TODO: trigger file picker / upload flow
    debugPrint('Upload for ${row.cells['propertyType']?.value}');
  }

  Future<void> _onDelete(BuildContext context, PlutoRow row) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete row?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok == true) {
      // TODO: call backend, then remove locally
      _stateManager?.removeRows([row]);
    }
  }

  void _onArchive(PlutoRow row) {
    // TODO: backend call
    debugPrint('Archive -> ${row.cells['phaseName']?.value}');
  }

  void showBuyerAssignmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BuyerAssigmentDialog();
      },
    );
  }

  void showPropertyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PropertyViewDialog();
      },
    );
  }

  getDefaultColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        // <- not number; we render custom UI
        enableSorting: false,
        readOnly: true,
        enableContextMenu: false,
        minWidth: 120,
        width: 120,
        renderer: (ctx) {
          // Grab whatever you need from the row:
          final propertyType = ctx.row.cells['propertyType']?.value;
          final phaseName = ctx.row.cells['phaseName']?.value;
          final phaseNumber = ctx.row.cells['phaseNumber']?.value;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: 'Open',
                child: IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => showPropertyDialog(context),
                  visualDensity: VisualDensity.compact,
                ),
              ),
              // Optional overflow menu if you want more actions without widening the column:
              PopupMenuButton<String>(
                tooltip: 'More',
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                  PopupMenuItem(value: 'archive', child: Text('Archive')),
                ],
                onSelected: (value) {
                  //if (value == 'delete') _onDelete(ctx.row);
                  if (value == 'archive') _onArchive(ctx.row);
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'Buyer',
        field: 'buyerAssigned',
        type: PlutoColumnType.text(),
        enableSorting: true,
        minWidth: 40,
        width: 120,
        enableContextMenu: false,
        readOnly: true,
        renderer: (rendererContext) {
          final value = rendererContext.cell.value;

          if (value == null || value.toString().trim().isEmpty) {
            return GestureDetector(
              child: AssignBuyerButton(
                tooltip: 'Assign Buyer',
                onPressed: () {
                  showBuyerAssignmentDialog(context);
                },
              ),
            );
          } else {
            return Text(value.toString(), overflow: TextOverflow.ellipsis);
          }
        },
      ),

      PlutoColumn(
        title: 'Unit Type',
        field: 'unitType',
        type: PlutoColumnType.text(),
        enableSorting: true,
        // click header to sort
        minWidth: 40,
        width: 100,
        // user can drag to resize in UI
        enableContextMenu: false,
        readOnly: true,
      ),

      PlutoColumn(
        title: 'Property Style',
        field: 'propertyStyle',
        type: PlutoColumnType.text(),
        enableSorting: true,
        // click header to sort
        minWidth: 40,
        width: 180,
        // user can drag to resize in UI
        enableContextMenu: false,
        readOnly: true,
      ),

      PlutoColumn(
        title: 'Sale Status',
        field: 'saleStatus',
        type: PlutoColumnType.select(kSaleStatuses),
        enableSorting: true,
        minWidth: 100,
        width: 240,
        enableContextMenu: false,
        readOnly: false,
        // 👈 must be editable for the dropdown
        renderer: (ctx) {
          final value = ctx.cell.value as String?;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // simple color mapping; tweak as you like
              color: switch (value) {
                'Awaiting Instruction' => const Color(0xFFE3F2FD),
                'Instructed' => const Color(0xFFE8F5E9),
                'Listed' => const Color(0xFFFFF3E0),
                'Reserved' => const Color(0xFFE8EAF6),
                'Booking Deposit Received' => const Color(0xFFFFEBEE),
                'Contracts Issued' => const Color(0xFFE3F2FD),
                'Snagging' => const Color(0xFFE8F5E9),
                'Snagged' => const Color(0xFFFFF3E0),
                'Snags Completed' => const Color(0xFFE8EAF6),
                'Complete' => const Color(0xFFFFEBEE),
                _ => Colors.grey.shade200,
              },
            ),
            child: Text(value ?? '', style: AppTextStyles.defaultFontStyle(14)),
          );
        },
      ),

      PlutoColumn(
        title: 'Build Status',
        field: 'buildStatus',
        type: PlutoColumnType.select(kBuildStatuses),
        enableSorting: true,
        minWidth: 100,
        width: 180,
        enableContextMenu: false,
        readOnly: false,
        // 👈 must be editable for the dropdown
        renderer: (ctx) {
          final value = ctx.cell.value as String?;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // simple color mapping; tweak as you like
              color: switch (value) {
                'Planning' => const Color(0xFFE3F2FD),
                'Pre Construction' => const Color(0xFFE8F5E9),
                'Groundwork and Foundations' => const Color(0xFFFFF3E0),
                'Structural Build' => const Color(0xFFE8EAF6),
                'First Fix' => const Color(0xFFFFEBEE),
                'External Finishes' => const Color(0xFFE3F2FD),
                'Second Fix' => const Color(0xFFE8F5E9),
                'Internal Finishes' => const Color(0xFFFFF3E0),
                'Handover Stage' => const Color(0xFFE8EAF6),
                'Complete' => const Color(0xFFFFEBEE),

                _ => Colors.grey.shade200,
              },
            ),
            child: Text(value ?? '', style: AppTextStyles.defaultFontStyle(14)),
          );
        },
      ),
      PlutoColumn(
        title: 'Phase Name',
        field: 'phaseName',
        type: PlutoColumnType.text(),
        enableSorting: true,
        minWidth: 140,
        enableContextMenu: false,
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Beds',
        field: 'bedsNumber',
        type: PlutoColumnType.number(),
        enableSorting: true,
        minWidth: 40,
        width: 70,
        enableContextMenu: false,
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Baths',
        field: 'bathsNumber',
        type: PlutoColumnType.number(),
        enableSorting: true,
        minWidth: 40,
        width: 70,
        enableContextMenu: false,
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Sqm',
        field: 'squareMeters',
        type: PlutoColumnType.number(),
        enableSorting: true,
        minWidth: 60,
        width: 80,
        enableContextMenu: false,
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Price',
        field: 'price',
        type: PlutoColumnType.number(),
        enableSorting: true,
        minWidth: 120,
        width: 120,
        enableContextMenu: false,
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Created',
        field: 'createdDate',
        type: PlutoColumnType.text(),
        enableSorting: true,
        minWidth: 120,
        width: 120,
        enableContextMenu: false,
        readOnly: true,
      ),
    ];
  }
}
