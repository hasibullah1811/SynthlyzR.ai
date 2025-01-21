import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/spreadsheet_file.dart';
import '../../domain/usecases/load_spreadsheet_usecase.dart';
import '../../domain/usecases/save_spreadsheet_usecase.dart';

class SpreadsheetNotifier extends StateNotifier<SpreadsheetFile?> {
  final LoadSpreadsheetUseCase loadSpreadsheetUseCase;
  final SaveSpreadsheetUseCase saveSpreadsheetUseCase;

  SpreadsheetNotifier(this.loadSpreadsheetUseCase, this.saveSpreadsheetUseCase)
      : super(null);

  Future<void> loadSpreadsheet(Uint8List bytes, String extension) async {
    final file = await loadSpreadsheetUseCase(bytes, extension);
    state = file;
  }

  Future<Uint8List?> saveSpreadsheet() async {
    if (state != null) {
      return await saveSpreadsheetUseCase(state!);
    }
    return null;
  }

  void updateCell(String sheetName, int row, int column, String newValue) {
    if (state != null) {
      final updatedSheets = state!.sheets.map((sheet) {
        if (sheet.name == sheetName) {
          final updatedData = List<List<String>>.from(sheet.data);
          updatedData[row][column] = newValue;
          return SpreadsheetSheet(name: sheet.name, data: updatedData);
        }
        return sheet;
      }).toList();

      state = SpreadsheetFile(type: state!.type, sheets: updatedSheets);
    }
  }
}
