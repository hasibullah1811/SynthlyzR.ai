import 'dart:typed_data';
import '../entities/spreadsheet_file.dart';

abstract class SpreadsheetRepository {
  Future<SpreadsheetFile> loadSpreadsheet(Uint8List bytes, String extension);
  Future<Uint8List> saveSpreadsheet(SpreadsheetFile file);
}
