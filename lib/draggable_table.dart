import 'package:flutter/material.dart';
import 'table_widget.dart';

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
