import '../../domain/entities/spreadsheet_file.dart';

class SpreadsheetFileModel extends SpreadsheetFile {
  SpreadsheetFileModel({
    required SpreadsheetType type,
    required List<SpreadsheetSheet> sheets,
  }) : super(type: type, sheets: sheets);

  factory SpreadsheetFileModel.fromEntity(SpreadsheetFile entity) {
    return SpreadsheetFileModel(type: entity.type, sheets: entity.sheets);
  }

  SpreadsheetFile toEntity() {
    return SpreadsheetFile(type: type, sheets: sheets);
  }
}
