import 'package:flutter/material.dart';
import 'table_widget.dart';
import 'column_widget.dart';
import 'draggable_table.dart';

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
