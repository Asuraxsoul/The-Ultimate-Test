import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_ultimate_test/utils/constants.dart';
import 'package:the_ultimate_test/widgets/reusable_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isPrivate = false;
  bool isWeekReminder = false;
  bool isDayReminder = false;
  bool isDarkMode = false;

  late double _height;
  late double _width;
  late String _setTime, _setDate;
  late String _hour, _minute, _time;
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    _timeController.text = DateFormat('kk:mm').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: ReusableHeader.getAppBar("Settings"),
      drawer: ReusableHeader.getDrawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color(0xFFace0f9),
                  Color(0xFFfff1eb),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey[700]!),
                        SizedBox(width: 7),
                        Text(
                          'ACCOUNT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            color: Colors.grey[800]!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(defaultPadding * 0.4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            child: ClipOval(
                              child: Material(
                                color: backgroundColor,
                                child: Image.network(
                                  user!.photoURL!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            '${user!.displayName}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(defaultPadding * 0.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Private Account',
                            style: TextStyle(fontSize: 16),
                          ),
                          FlutterSwitch(
                            width: 65.0,
                            height: 45.0,
                            valueFontSize: 18.0,
                            toggleSize: 20.0,
                            value: isPrivate,
                            borderRadius: 30.0,
                            padding: 5.0,
                            showOnOff: true,
                            activeColor: Color.fromRGBO(51, 255, 180, 1),
                            inactiveColor: Colors.black38,
                            switchBorder: Border.all(
                              color:
                                  isPrivate ? basicColorGreen : Colors.white70,
                              width: 1.0,
                            ),
                            activeTextColor: Colors.lightGreenAccent[100]!,
                            inactiveTextColor: Colors.red.withOpacity(0.8),
                            activeTextFontWeight: FontWeight.bold,
                            inactiveTextFontWeight: FontWeight.bold,
                            onToggle: (val) {
                              setState(() {
                                isPrivate = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.grey[700]!),
                        SizedBox(width: 7),
                        Text(
                          'PUSH NOTIFICATIONS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            color: Colors.grey[800]!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      //height: 50,
                      padding: EdgeInsets.all(defaultPadding * 0.4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Selected Test Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${_dateController.text}, ${_timeController.text}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Date',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        letterSpacing: 0.5),
                                  ),
                                  SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: 150,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200]),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dateController,
                                        onSaved: (String? val) {
                                          _setDate = val as String;
                                        },
                                        decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.5,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      _selectTime(context);
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200]),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                        onSaved: (String? val) {
                                          _setTime = val as String;
                                        },
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _timeController,
                                        decoration: InputDecoration(
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(defaultPadding * 0.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remind me 1 week before',
                            style: TextStyle(fontSize: 16),
                          ),
                          FlutterSwitch(
                            width: 65.0,
                            height: 45.0,
                            valueFontSize: 18.0,
                            toggleSize: 20.0,
                            value: isWeekReminder,
                            borderRadius: 30.0,
                            padding: 5.0,
                            showOnOff: true,
                            activeColor: Color.fromRGBO(51, 255, 180, 1),
                            inactiveColor: Colors.black38,
                            switchBorder: Border.all(
                              color: isWeekReminder
                                  ? basicColorGreen
                                  : Colors.white70,
                              width: 1.0,
                            ),
                            activeTextColor: Colors.lightGreenAccent[100]!,
                            inactiveTextColor: Colors.red.withOpacity(0.8),
                            activeTextFontWeight: FontWeight.bold,
                            inactiveTextFontWeight: FontWeight.bold,
                            onToggle: (val) {
                              setState(() {
                                isWeekReminder = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(defaultPadding * 0.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remind me 1 day before',
                            style: TextStyle(fontSize: 16),
                          ),
                          FlutterSwitch(
                            width: 65.0,
                            height: 45.0,
                            valueFontSize: 18.0,
                            toggleSize: 20.0,
                            value: isDayReminder,
                            borderRadius: 30.0,
                            padding: 5.0,
                            showOnOff: true,
                            activeColor: Color.fromRGBO(51, 255, 180, 1),
                            inactiveColor: Colors.black38,
                            switchBorder: Border.all(
                              color: isDayReminder
                                  ? basicColorGreen
                                  : Colors.white70,
                              width: 1.0,
                            ),
                            activeTextColor: Colors.lightGreenAccent[100]!,
                            inactiveTextColor: Colors.red.withOpacity(0.8),
                            activeTextFontWeight: FontWeight.bold,
                            inactiveTextFontWeight: FontWeight.bold,
                            onToggle: (val) {
                              setState(() {
                                isDayReminder = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.remove_red_eye_rounded,
                            color: Colors.grey[700]!),
                        SizedBox(width: 7),
                        Text(
                          'APPEARANCE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            color: Colors.grey[800]!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(defaultPadding * 0.5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        color: Colors.white70.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dark Mode',
                            style: TextStyle(fontSize: 16),
                          ),
                          FlutterSwitch(
                            width: 65.0,
                            height: 45.0,
                            valueFontSize: 18.0,
                            toggleSize: 20.0,
                            value: isDarkMode,
                            borderRadius: 30.0,
                            padding: 5.0,
                            showOnOff: true,
                            activeColor: Color.fromRGBO(51, 255, 180, 1),
                            inactiveColor: Colors.black38,
                            switchBorder: Border.all(
                              color:
                                  isDarkMode ? basicColorGreen : Colors.white70,
                              width: 1.0,
                            ),
                            activeTextColor: Colors.lightGreenAccent[100]!,
                            inactiveTextColor: Colors.red.withOpacity(0.8),
                            activeTextFontWeight: FontWeight.bold,
                            inactiveTextFontWeight: FontWeight.bold,
                            onToggle: (val) {
                              setState(() {
                                isDarkMode = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.headphones, color: Colors.grey[700]!),
                        SizedBox(width: 7),
                        Text(
                          'HELP & SUPPORT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            color: Colors.grey[800]!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[700]!,
                                insetPadding: EdgeInsets.all(defaultPadding),
                                title: Text(
                                  "Email us any query:",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                content: Text(
                                  "viscountlapiz@gmail.com",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: basicColorPink,
                                    letterSpacing: 2.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: new Icon(
                                      Icons.done,
                                      color: basicColorLBlue,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(defaultPadding * 0.5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!),
                          color: Colors.white70.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Contact Us',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            Icon(Icons.navigate_next_outlined,
                                color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
