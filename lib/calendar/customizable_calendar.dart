import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomizableCalendar extends StatefulWidget {
  @override
  _CustomizableCalendarState createState() => _CustomizableCalendarState();
}

class _CustomizableCalendarState extends State<CustomizableCalendar> {
  final DateTime currentDate = DateTime.now();

  late int currentDay;
  bool isInitial = true;

  @override
  void initState() {
    super.initState();
    currentDay = currentDate.day;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _monthTitle(),
            _dayWeekRow(),
            ..._currentMonthField(context),
            SizedBox(height: 40),
            // ..._proposalsList(),
          ],
        ),
      ),
    );
  }

  Widget _monthTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 40),
      child: Text(
        DateFormat('yMMMM').format(currentDate.toLocal()),
        style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _dayWeekRow() {
    List<String> weekDayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    List<Widget> widgetsList = List.generate(
      weekDayNames.length,
      (index) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            weekDayNames[index],
            style: GoogleFonts.roboto(fontSize: 12, letterSpacing: 0.32),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(children: widgetsList),
    );
  }

  Widget _dayItem(int day, BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: currentDate.day == day ? Colors.lightGreen : Colors.transparent,
            border: currentDay == day ? Border.all(width: 2, color: Colors.black) : Border.all(width: 2, color: Colors.transparent),
            shape: BoxShape.circle),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // splashColor: Colors.lightGreen,
            customBorder: CircleBorder(),
            onTap: () {
              setState(() {
                currentDay = day;
              });
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                day != 0 ? day.toString() : ' ',
                style: currentDay == day
                    ? GoogleFonts.roboto(fontSize: 12, letterSpacing: 0.32, fontWeight: FontWeight.w700, color: Colors.black)
                    : GoogleFonts.roboto(fontSize: 12, letterSpacing: 0.32, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _currentMonthField(BuildContext context) {
    var currentMonth = currentDate.month;
    var countOfDays = DateTime(currentDate.year, currentMonth + 1, 0).day;
    var weekDay = DateTime(currentDate.year, currentMonth, 1).weekday;

    List<int> dayList = List.generate(countOfDays, (index) => index + 1);

    List<Widget> widgetsList = [];
    List<Widget> tmpList = [];

    for (int i = 0; i < dayList.length; i++) {
      tmpList.add(_dayItem(dayList[i], context));

      if (((i + 1).remainder(7) == 0 && i != 0) || i == dayList.length - 1) {
        widgetsList.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Row(children: tmpList),
          ),
        );
        tmpList = [];
      }
    }
    return widgetsList;
  }

// List<Widget> _proposalsList() {
//   List<Widget> widgetsList = [];
//   currentDay.workDayList.forEach((element) {
//     widgetsList.add(WorkCalendarItem(work: element));
//   });
//   return widgetsList;
// }
}
