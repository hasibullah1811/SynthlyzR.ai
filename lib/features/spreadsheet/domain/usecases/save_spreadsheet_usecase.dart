import 'dart:typed_data';
import '../entities/spreadsheet_file.dart';
import '../repository/spreadsheet_repository.dart';

class SaveSpreadsheetUseCase {
  final SpreadsheetRepository repository;

  SaveSpreadsheetUseCase(this.repository);

  Future<Uint8List> call(SpreadsheetFile file) {
    return repository.saveSpreadsheet(file);
  }
}
