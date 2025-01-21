import 'dart:typed_data';
import '../entities/spreadsheet_file.dart';
import '../repository/spreadsheet_repository.dart';

class LoadSpreadsheetUseCase {
  final SpreadsheetRepository repository;

  LoadSpreadsheetUseCase(this.repository);

  Future<SpreadsheetFile> call(Uint8List bytes, String extension) {
    return repository.loadSpreadsheet(bytes, extension);
  }
}
