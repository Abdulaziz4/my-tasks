import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/model/task.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewTask extends StatefulWidget {
  final Function passData;

  NewTask(this.passData);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _textEditingController = TextEditingController();

  DateTime selectedDate;

  DateTime startTime;

  DateTime finishTime;

  void submitData(BuildContext ctx) {
    print(_textEditingController.text);
    if (_textEditingController.text.isEmpty ||
        finishTime == null ||
        selectedDate == null ||
        startTime == null) return;
    print(_textEditingController.text);
    widget.passData(new Task(
        text: _textEditingController.text,
        date: selectedDate,
        startTime: startTime,
        finishTime: finishTime));
    Navigator.of(ctx).pop();
  }

  void _datePicker(BuildContext ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2021),
    ).then((value) {
      if (value == null) return;
      setState(() {
        selectedDate = value;
      });
    });
  }

  void _timePicker(BuildContext ctx, String startOrFinish) {
    DatePicker.showTime12hPicker(ctx, currentTime: DateTime.now(),
        onChanged: (value) {
      print(value);
      setState(() {
        if (value == null) return;
        if (startOrFinish == "start")
          startTime = value;
        else
          finishTime = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        color: Colors.white12,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "اضف هنا",
                labelStyle: TextStyle(),
              ),
              textDirection: TextDirection.rtl,
              controller: _textEditingController,
            ),
            FlatButton.icon(
              label: selectedDate == null
                  ? Text(
                      "التاريخ",
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(fontSize: 17)),
                    )
                  : Text(selectedDate.year.toString() +
                      "/" +
                      selectedDate.month.toString() +
                      "/" +
                      selectedDate.day.toString()),
              icon: Icon(Icons.event),
              onPressed: () => _datePicker(context),
            ),
            FlatButton.icon(
              onPressed: () => _timePicker(context, "start"),
              icon: Icon(Icons.timer),
              label: startTime == null
                  ? Text(
                      "البداية",
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(fontSize: 17)),
                    )
                  : Text(startTime.hour.toString() +
                      ":" +
                      startTime.minute.toString()),
            ),
            FlatButton.icon(
              onPressed: () => _timePicker(context, "finish"),
              icon: Icon(Icons.timer_off),
              label: finishTime == null
                  ? Text(
                      "النهاية",
                      style: GoogleFonts.tajawal(
                          textStyle: TextStyle(fontSize: 17)),
                    )
                  : Text(finishTime.hour.toString() +
                      ":" +
                      finishTime.minute.toString()),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 40,
              width: 150,
              child: RaisedButton(
                color: Color(0xFFC7AB50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => submitData(context),
                child: Text(
                  "أضف",
                  style:
                      GoogleFonts.tajawal(textStyle: TextStyle(fontSize: 17)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
