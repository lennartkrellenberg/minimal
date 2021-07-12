import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDoItem extends StatefulWidget {
  final String toDoText;
  final String priority;
  final String category;
  final String categoryColor;
  final String priorityColor;

  ToDoItem(this.toDoText, this.category, this.priority, this.categoryColor,
      this.priorityColor);

  @override
  State<StatefulWidget> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90,
        width: (MediaQuery.of(context).size.width),
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            border: Border.all(color: Color.fromRGBO(68, 68, 68, 1)),
            borderRadius: new BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      widget.toDoText,
                      style: new TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 24,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(9.0)),
                          color: Color(int.parse(widget.categoryColor))),
                      child: Text(
                        widget.category,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(Radius.circular(9.0)),
                        color: Color(int.parse(widget.priorityColor)),
                      ),
                      child: Text(
                        widget.priority,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
