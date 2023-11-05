
import 'column_widget.dart';

class TableWidget {
  final String tableName;
  final List<ColumnWidget> columns;
  double maxWidth = 150.0;
  double maxHeight = 300;

  TableWidget({
    required this.tableName,
    required this.columns,
  });
}
