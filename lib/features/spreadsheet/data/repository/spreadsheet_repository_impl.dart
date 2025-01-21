import 'dart:typed_data';
import '../../domain/entities/spreadsheet_file.dart';
import '../../domain/repository/spreadsheet_repository.dart';
import '../models/spreadsheet_file_model.dart';
import '../sources/csv_handler.dart';
import '../sources/excel_handler.dart';

class SpreadsheetRepositoryImpl implements SpreadsheetRepository {
  final CsvHandler csvHandler;
  final ExcelHandler excelHandler;

  SpreadsheetRepositoryImpl(this.csvHandler, this.excelHandler);

  @override
  Future<SpreadsheetFile> loadSpreadsheet(
      Uint8List bytes, String extension) async {
    if (extension == 'xlsx') {
      return excelHandler.loadExcel(bytes).toEntity();
    } else if (extension == 'csv') {
      return csvHandler.loadCsv(bytes).toEntity();
    } else {
      throw UnsupportedError('Unsupported file type');
    }
  }

  @override
  Future<Uint8List> saveSpreadsheet(SpreadsheetFile file) async {
    final fileModel = SpreadsheetFileModel.fromEntity(file); // Convert to model
    if (file.type == SpreadsheetType.excel) {
      return excelHandler.saveExcel(fileModel);
    } else if (file.type == SpreadsheetType.csv) {
      return csvHandler.saveCsv(fileModel);
    } else {
      throw UnsupportedError('Unsupported file type');
    }
  }
}
