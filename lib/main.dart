import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/widget/new_task.dart';
import './model/task.dart';
import './widget/todo.dart';
import 'package:intl/intl.dart' as intl;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(title: 'مهامي'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> _userTask = [];

  void addTask(Task toAdd) {
    setState(() {
      _userTask.add(toAdd);
    });
  }

  void deleteTask(Task toDelete) {
    setState(() {
      _userTask.remove(toDelete);
    });
  }

  void startAddingNewTask() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTask(addTask);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: mediaQuery.size.height * 0.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF50C791), Color(0xFF50C791).withOpacity(0.6)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                Container(
                  margin: EdgeInsets.only(left: 13),
                  child: Text(
                      intl.DateFormat().add_yMMMMEEEEd().format(DateTime.now()),
                      style: GoogleFonts.montserrat()),
                ),
                Center(
                  child: Text(
                    "مهامي",
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ),
              ],
            ),
          ),
          _userTask.isEmpty
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: mediaQuery.size.height * 0.15,
                    ),
                    Text(
                      " ماعندك مهام !",
                      style: GoogleFonts.changa(
                          textStyle: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: mediaQuery.size.height * 0.05,
                    ),
                    Container(
                      height: mediaQuery.size.height * 0.3,
                      child: Image.asset(
                        "assets/images/waiting.png",
                      ),
                    ),
                  ],
                )
              : Container(
                  height: mediaQuery.size.height * 0.8,
                  child: ListView.builder(
                      itemCount: _userTask.length,
                      itemBuilder: (context, index) {
                        return ToDo(_userTask[index], deleteTask);
                      })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFC7AB50),
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 7,
        onPressed: () {
          startAddingNewTask();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
