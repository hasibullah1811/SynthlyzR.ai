import 'package:flutter/material.dart';
import '../../domain/entities/spreadsheet_file.dart';

class SpreadsheetTableWidget extends StatelessWidget {
  final SpreadsheetFile file;
  final Function(String sheetName, int row, int column, String newValue)
      onEditCell;

  const SpreadsheetTableWidget({
    Key? key,
    required this.file,
    required this.onEditCell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sheet = file.sheets.first; // Display the first sheet

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Horizontal scrolling
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Vertical scrolling
        child: Table(
          border: TableBorder.all(color: Colors.grey),
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            for (int rowIndex = 0; rowIndex < sheet.data.length; rowIndex++)
              TableRow(
                children: [
                  for (int columnIndex = 0;
                      columnIndex < sheet.data[rowIndex].length;
                      columnIndex++)
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          initialValue: sheet.data[rowIndex][columnIndex],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                          ),
                          onChanged: (newValue) {
                            // Update the specific cell
                            onEditCell(
                                sheet.name, rowIndex, columnIndex, newValue);
                          },
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
