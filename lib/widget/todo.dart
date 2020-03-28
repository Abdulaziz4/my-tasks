import 'package:flutter/material.dart';
import '../model/task.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDo extends StatefulWidget {
  final Task task;
  final Function remove;
  ToDo(this.task, this.remove);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: UniqueKey(),
      onDismissed: (direction) {
        widget.remove(widget.task);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(7, 0, 7, 15),
        width: 390,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(5, 5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: ListTile(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // children: <Widget>[
            leading: IconButton(
                iconSize: 40,
                color: Color(0xFFC7AB50),
                icon: Icon(widget.task.check
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () {
                  setState(() {
                    widget.task.check
                        ? widget.task.check = false
                        : widget.task.check = true;
                  });
                }),
            title: Text(
              widget.task.text,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 18,
                  decorationColor: Colors.red,
                  // decorationColor: Colors.green,
                  decorationStyle: TextDecorationStyle.solid,
                  decoration:
                      widget.task.check ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat.yMd().format(widget.task.date),
                  style: GoogleFonts.montserrat(fontSize: 13),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    // widget.task.startTime.hour.toString() +
                    //     ":" +
                    //     widget.task.startTime.minute.toString() +
                    DateFormat("h:mma").format(widget.task.startTime) +
                        " - " +
                        DateFormat("h:mma").format(widget.task.finishTime),
                    // " - " +
                    // widget.task.finishTime.hour.toString() +
                    // ":" +
                    // widget.task.finishTime.minute.toString(),
                    style: GoogleFonts.montserrat(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
