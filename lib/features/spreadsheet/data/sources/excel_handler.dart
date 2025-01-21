import 'dart:typed_data';
import 'package:excel/excel.dart';
import '../../domain/entities/spreadsheet_file.dart';
import '../models/spreadsheet_file_model.dart';

class ExcelHandler {
  SpreadsheetFileModel loadExcel(Uint8List bytes) {
    final excel = Excel.decodeBytes(bytes);

    final sheets = excel.tables.entries.map((entry) {
      final data = entry.value.rows.map((row) {
        return row.map((cell) => cell?.value?.toString() ?? "").toList();
      }).toList();
      return SpreadsheetSheet(name: entry.key, data: data);
    }).toList();

    return SpreadsheetFileModel(type: SpreadsheetType.excel, sheets: sheets);
  }

  Uint8List saveExcel(SpreadsheetFileModel file) {
    final excel = Excel.createExcel();
    for (var sheet in file.sheets) {
      final sheetObj = excel[sheet.name];
      for (var row in sheet.data) {
        sheetObj.appendRow(row);
      }
    }
    return Uint8List.fromList(excel.encode()!);
  }
}
