import 'package:flutter/material.dart';
import 'column_widget.dart';

class TableWidget extends StatelessWidget {
  final String tableName;
  final Offset position;
  final VoidCallback onTableDragged;
  final List<ColumnWidget> columns;

  TableWidget({
    required this.tableName,
    required this.position,
    required this.onTableDragged,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: tableName,
      onDraggableCanceled: (_, offset) {
        onTableDragged();
      },
      feedback: Container(
        width: 50, // Adjust the width as needed
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.7),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Text(
              tableName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Column(
              children: columns,
            ),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: [
            Text(
              tableName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
