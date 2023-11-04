import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ERD Designer')),
        body: ERDPage(),
      ),
    );
  }
}

class ERDPage extends StatefulWidget {
  @override
  _ERDPageState createState() => _ERDPageState();
}

class _ERDPageState extends State<ERDPage> {
  List<TableWidget> tables = [];
  int tableCounter = 0;
  List<Offset> tablePositions = [];
  TextEditingController tableNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tableNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Table Name',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (tableNameController.text.isNotEmpty) {
                    addTable(tableNameController.text);
                    tableNameController.clear();
                  }
                },
                child: Text('Add Table'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                for (int i = 0; i < tables.length; i++)
                  Positioned(
                    left: tablePositions[i].dx,
                    top: tablePositions[i].dy,
                    child: DraggableTableWidget(
                      table: tables[i],
                      onDragEnd: (Offset offset) {
                        saveTablePosition(i, offset);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addTable(String tableName) {
    setState(() {
      tableCounter++;
      tables.add(
        TableWidget(
          tableName: tableName,
          columns: [
            ColumnWidget(
              columnName: "id",
              columnType: "uuid",
              primaryKey: true,
              autoIncrement: true,
              nullable: false,
            ),
            ColumnWidget(
              columnName: "column1",
              columnType: "varchar",
              primaryKey: false,
              autoIncrement: false,
              nullable: false,
            ),
            ColumnWidget(
              columnName: "column2",
              columnType: "text",
              primaryKey: false,
              autoIncrement: false,
              nullable: false,
            ),
          ],
        ),
      );
      tablePositions.add(Offset(0, 0));
    });
  }

  void saveTablePosition(int index, Offset offset) {
    setState(() {
      tablePositions[index] = offset;
    });
  }
}

class DraggableTableWidget extends StatelessWidget {
  final TableWidget table;
  final ValueChanged<Offset> onDragEnd;

  DraggableTableWidget({
    required this.table,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Card(
        child: Container(
          width: table.maxWidth,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Text(
                  table.tableName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(color: Colors.blue),
                SingleChildScrollView(
                  child: Column(
                    children: table.columns,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      childWhenDragging: Container(),
      child: Card(
        child: Container(
          width: table.maxWidth,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Text(
                  table.tableName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(color: Colors.blue),
                SingleChildScrollView(
                  child: Column(
                    children: table.columns,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        onDragEnd(offset);
      },
    );
  }
}

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

class ColumnWidget extends StatelessWidget {
  final String columnName;
  final String columnType;
  final bool primaryKey;
  final bool autoIncrement;
  final bool nullable;

  ColumnWidget({
    required this.columnName,
    required this.columnType,
    this.primaryKey = false,
    this.autoIncrement = false,
    this.nullable = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(columnName),
      subtitle: Text(columnType),
    );
  }
}
