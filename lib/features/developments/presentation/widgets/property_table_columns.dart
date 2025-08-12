import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PropertyTableColumns {
  PlutoGridStateManager? _stateManager;

  static const kBuildStatuses = <String>['Planned', 'In Progress', 'Snagging', 'Complete', 'On Hold'];

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

  getDefaultColumns() {
    return [
      PlutoColumn(
        title: 'House No.',
        field: 'houseNumber',
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
        title: 'Status',
        field: 'assignmentStatus',
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
        title: 'Buyer Assigned',
        field: 'buyerAssignment',
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
        title: 'Build Status',
        field: 'buildStatus',
        type: PlutoColumnType.select(kBuildStatuses),
        enableSorting: true,
        minWidth: 100,
        width: 140,
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
                'Planned' => const Color(0xFFE3F2FD),
                'In Progress' => const Color(0xFFE8F5E9),
                'Snagging' => const Color(0xFFFFF3E0),
                'Complete' => const Color(0xFFE8EAF6),
                'On Hold' => const Color(0xFFFFEBEE),
                _ => Colors.grey.shade200,
              },
            ),
            child: Text(value ?? '', style: const TextStyle(fontSize: 12)),
          );
        },
      ),
      PlutoColumn(
        title: 'Sale Status',
        field: 'saleStatus',
        type: PlutoColumnType.text(),
        enableSorting: true,
        // click header to sort
        minWidth: 140,
        // user can drag to resize in UI
        enableContextMenu: false,
        readOnly: true,
      ),
      PlutoColumn(
        title: 'Property Type',
        field: 'propertyType',
        type: PlutoColumnType.text(),
        enableSorting: true,
        // click header to sort
        minWidth: 140,
        // user can drag to resize in UI
        enableContextMenu: false,
        readOnly: true,
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
        title: 'Phase #',
        field: 'phaseNumber',
        type: PlutoColumnType.number(),
        enableSorting: true,
        minWidth: 65,
        width: 65,
        enableContextMenu: false,
        readOnly: true,
      ),

      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.text(),
        // <- not number; we render custom UI
        enableSorting: false,
        // actions shouldn't sort
        readOnly: true,
        enableContextMenu: false,
        minWidth: 160,
        width: 180,
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
                  onPressed: () => _onOpen(ctx.row),
                  visualDensity: VisualDensity.compact,
                ),
              ),
              Tooltip(
                message: 'Edit',
                child: IconButton(icon: const Icon(Icons.edit), onPressed: () => _onEdit(ctx.row), visualDensity: VisualDensity.compact),
              ),
              Tooltip(
                message: 'Upload file',
                child: IconButton(
                  icon: const Icon(Icons.upload_file),
                  onPressed: () => _onUpload(ctx.row),
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
    ];
  }
}
