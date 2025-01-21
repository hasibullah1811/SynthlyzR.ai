import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/spreadsheet_repository_impl.dart';
import '../../data/sources/csv_handler.dart';
import '../../data/sources/excel_handler.dart';
import '../../domain/entities/spreadsheet_file.dart';
import '../../domain/usecases/load_spreadsheet_usecase.dart';
import '../../domain/usecases/save_spreadsheet_usecase.dart';
import 'spreadsheet_notifier.dart';

final csvHandlerProvider = Provider((ref) => CsvHandler());
final excelHandlerProvider = Provider((ref) => ExcelHandler());

final spreadsheetFileProvider =
    StateNotifierProvider<SpreadsheetNotifier, SpreadsheetFile?>((ref) {
  final loadUseCase = ref.watch(loadSpreadsheetUseCaseProvider);
  final saveUseCase = ref.watch(saveSpreadsheetUseCaseProvider);
  return SpreadsheetNotifier(loadUseCase, saveUseCase);
});

final spreadsheetRepositoryProvider = Provider((ref) {
  return SpreadsheetRepositoryImpl(
    ref.watch(csvHandlerProvider),
    ref.watch(excelHandlerProvider),
  );
});

final loadSpreadsheetUseCaseProvider = Provider((ref) {
  return LoadSpreadsheetUseCase(ref.watch(spreadsheetRepositoryProvider));
});

final saveSpreadsheetUseCaseProvider = Provider((ref) {
  return SaveSpreadsheetUseCase(ref.watch(spreadsheetRepositoryProvider));
});
