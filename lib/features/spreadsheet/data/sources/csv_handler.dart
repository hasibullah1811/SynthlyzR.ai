import 'dart:typed_data';
import 'package:csv/csv.dart';
import '../../domain/entities/spreadsheet_file.dart';
import '../models/spreadsheet_file_model.dart';

class CsvHandler {
  SpreadsheetFileModel loadCsv(Uint8List bytes) {
    final content = String.fromCharCodes(bytes);

    // Parse the CSV content into rows and columns
    final csvData = const CsvToListConverter().convert(
      content,
      eol: '\n', // Handle line breaks properly
    );

    // Convert the parsed CSV data to a SpreadsheetFileModel
    return SpreadsheetFileModel(
      type: SpreadsheetType.csv,
      sheets: [
        SpreadsheetSheet(
          name: 'CSV Sheet',
          data: csvData.map((row) {
            // Ensure each cell is converted to a string
            return row.map((cell) => cell.toString()).toList();
          }).toList(),
        ),
      ],
    );
  }

  Uint8List saveCsv(SpreadsheetFileModel file) {
    final csvData = const ListToCsvConverter().convert(file.sheets.first.data);
    return Uint8List.fromList(csvData.codeUnits);
  }
}
