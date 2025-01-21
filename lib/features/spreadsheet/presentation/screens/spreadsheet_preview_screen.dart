import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../provider/spreadsheet_provider.dart';

import '../widgets/spreadsheet_table_widget.dart';

class SpreadsheetPreviewScreen extends ConsumerWidget {
  const SpreadsheetPreviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spreadsheetFile = ref.watch(spreadsheetFileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Spreadsheet Preview"),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: () async {
              // Open and load a new file
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx', 'csv'],
                withData: true, // Load the file's bytes for web compatibility
              );

              if (result != null && result.files.single.bytes != null) {
                final bytes = result.files.single.bytes!;
                final extension = result.files.single.extension;

                if (extension == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Unsupported file type.")),
                  );
                  return;
                }

                // Load the selected file
                ref
                    .read(spreadsheetFileProvider.notifier)
                    .loadSpreadsheet(bytes, extension);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: spreadsheetFile != null
                ? () async {
                    final notifier = ref.read(spreadsheetFileProvider.notifier);
                    final bytes = await notifier.saveSpreadsheet();

                    if (bytes != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("File saved successfully!")),
                      );
                    }
                  }
                : null,
          ),
        ],
      ),
      body: spreadsheetFile == null
          ? const Center(
              child: Text("No spreadsheet loaded"),
            )
          : SpreadsheetTableWidget(
              file: spreadsheetFile,
              onEditCell: (sheetName, row, column, newValue) {
                ref
                    .read(spreadsheetFileProvider.notifier)
                    .updateCell(sheetName, row, column, newValue);
              },
            ),
    );
  }
}
