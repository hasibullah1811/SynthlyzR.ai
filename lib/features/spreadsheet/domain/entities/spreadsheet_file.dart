enum SpreadsheetType { excel, csv }

class SpreadsheetFile {
  final SpreadsheetType type;
  final List<SpreadsheetSheet> sheets;

  SpreadsheetFile({required this.type, required this.sheets});
}

class SpreadsheetSheet {
  final String name;
  final List<List<String>> data;

  SpreadsheetSheet({required this.name, required this.data});
}
