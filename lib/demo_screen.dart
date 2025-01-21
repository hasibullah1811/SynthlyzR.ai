import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:csv/csv.dart';
import 'package:universal_html/html.dart';

class SpreadsheetEditorScreen extends StatefulWidget {
  @override
  _SpreadsheetEditorScreenState createState() =>
      _SpreadsheetEditorScreenState();
}

class _SpreadsheetEditorScreenState extends State<SpreadsheetEditorScreen> {
  Uint8List? fileBytes;
  String? fileName;
  String? fileType;
  List<List<String>> sheetData = [];
  String sheetName = "Sheet1"; // Default sheet name for CSV

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spreadsheet Editor"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: fileBytes != null ? _saveSpreadsheet : null,
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndLoadSpreadsheet,
            child: const Text("Open Spreadsheet File"),
          ),
          const SizedBox(height: 16),
          fileBytes != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: sheetData.length,
                    itemBuilder: (context, rowIndex) {
                      final row = sheetData[rowIndex];
                      return Row(
                        children: row.map((cell) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: cell,
                                onChanged: (newValue) {
                                  setState(() {
                                    sheetData[rowIndex][row.indexOf(cell)] =
                                        newValue;
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text("No file loaded"),
                ),
        ],
      ),
    );
  }

  Future<void> _pickAndLoadSpreadsheet() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'],
      withData: true, // This ensures the bytes are accessible
    );

    if (result != null) {
      fileBytes = result.files.single.bytes;
      fileName = result.files.single.name;
      final extension = fileName!.split('.').last.toLowerCase();

      if (extension == 'xlsx') {
        await _loadExcel(fileBytes!);
        fileType = "excel";
      } else if (extension == 'csv') {
        await _loadCsv(fileBytes!);
        fileType = "csv";
      }

      setState(() {});
    }
  }

  Future<void> _loadExcel(Uint8List bytes) async {
    final excel = Excel.decodeBytes(bytes);

    if (excel.tables.isNotEmpty) {
      final firstSheet = excel.tables.keys.first;
      final data = excel.tables[firstSheet]!.rows.map((row) {
        return row.map((cell) => cell?.value?.toString() ?? "").toList();
      }).toList();

      setState(() {
        sheetName = firstSheet;
        sheetData = data;
      });
    }
  }

  Future<void> _loadCsv(Uint8List bytes) async {
    final fileContent = String.fromCharCodes(bytes);
    final csvData = const CsvToListConverter().convert(fileContent);

    setState(() {
      sheetData = csvData.map((row) {
        return row.map((cell) => cell.toString()).toList();
      }).toList();
    });
  }

  Future<void> _saveSpreadsheet() async {
    if (fileType == "excel") {
      await _saveExcel();
    } else if (fileType == "csv") {
      await _saveCsv();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Spreadsheet saved successfully!")),
    );
  }

  Future<void> _saveExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel[sheetName];

    for (var row in sheetData) {
      sheet.appendRow(row);
    }

    final bytes = excel.encode();

    if (bytes != null) {
      // _downloadFile(bytes, "edited_$fileName");
    }
  }

  Future<void> _saveCsv() async {
    final csvData = const ListToCsvConverter().convert(sheetData);
    final bytes = Uint8List.fromList(csvData.codeUnits);

    _downloadFile(bytes, "edited_$fileName");
  }

  void _downloadFile(Uint8List bytes, String downloadName) {
    final blob = Blob([bytes]);
    final url = Url.createObjectUrlFromBlob(blob);
    final anchor = AnchorElement(href: url)
      ..target = 'blank'
      ..download = downloadName
      ..click();
    Url.revokeObjectUrl(url);
  }
}
