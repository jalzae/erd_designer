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

class ERDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TableWidget(
        tableName: "User",
        columns: [
          ColumnWidget(
            columnName: "id",
            columnType: "uuid",
            primaryKey: true,
            autoIncrement: true,
            nullable: false,
          ),
          ColumnWidget(
            columnName: "username",
            columnType: "varchar",
            primaryKey: false,
            autoIncrement: false,
            nullable: false,
          ),
          ColumnWidget(
            columnName: "password",
            columnType: "text",
            primaryKey: false,
            autoIncrement: false,
            nullable: false,
          ),
          ColumnWidget(
            columnName: "email",
            columnType: "varchar",
            primaryKey: false,
            autoIncrement: false,
            nullable: true,
          ),
        ],
      ),
    );
  }
}

class TableWidget extends StatefulWidget {
  final String tableName;
  final List<ColumnWidget> columns;

  TableWidget({
    required this.tableName,
    required this.columns,
  });

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  Offset position = Offset(0, 0);
  double maxWidth=0;
  double maxHeight=0;

  @override
  void initState() {
    super.initState();
    maxWidth = 150.0; // Set your desired max width
    maxHeight = 300; // Initial max height
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: Draggable(
            feedback: Card(
              // Wrap the content with a Card
              child: Container(
                width: maxWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Text(
                        widget.tableName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Divider(color: Colors.blue),
                      // Use a Column with SingleChildScrollView
                      SingleChildScrollView(
                        child: Column(
                          children: widget.columns,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            childWhenDragging: Container(),
            child: Card(
              // Wrap the content with a Card
              child: Container(
                width: maxWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Text(
                        widget.tableName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Divider(color: Colors.blue),
                      // Use a Column with SingleChildScrollView
                      SingleChildScrollView(
                        child: Column(
                          children: widget.columns,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              setState(() {
                position = Offset(
                  offset.dx
                      .clamp(0.0, MediaQuery.of(context).size.width - maxWidth),
                  offset.dy.clamp(
                      0.0, MediaQuery.of(context).size.height - maxHeight),
                );
              });
            },
          ),
        ),
      ],
    );
  }
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
