import 'package:flutter/material.dart';
import 'logWidget.dart';
import 'getLogs.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  int _selectedDateIndex = 0;
  List<DateTime> _dates = [];
  List<LogWidget> _logs = [];

  @override
  void initState() {
    super.initState();
    _dates = generateDates(28);
    _fetchLogs();
  }

    //adding a list of dates (only March)
    List<DateTime> generateDates(int numDays) {
    final today = DateTime.now();
    final dates = List.generate(numDays, (index) => today.subtract(Duration(days: index)));
    return dates.reversed.toList();
  }

  //getting the logs
  Future<void> _fetchLogs() async {
    final token = await getToken();
    final logs = await getLogs(token);
    setState(() {
      _logs = logs.cast<LogWidget>();
    });
  }

  // Design and logic of app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black12,
        child: InkWell(
          onTap: () => print('home'),
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const Text('Home'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDateIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _selectedDateIndex == index
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${_dates[index].day}.${_dates[index].month}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: _selectedDateIndex == index
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // left/right swipe
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  // Swiped right
                  setState(() {
                    if (_selectedDateIndex > 0) {
                      _selectedDateIndex--;
                    }
                  });
                } else if (details.primaryVelocity! < 0) {
                  // Swiped left
                  setState(() {
                    if (_selectedDateIndex < _dates.length - 1) {
                      _selectedDateIndex++;
                    }
                  });
                }
              },
              // finding the right logs for the right dates
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: _logs.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const SizedBox(height: 16.0),
                          Text(
                            '${_dates[_selectedDateIndex].day}.${_dates[_selectedDateIndex].month}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      );
                    } else {
                      final log = _logs[index - 1];
                      final logDate = log.dateStr;
                      final selectedDate = _dates[_selectedDateIndex];

                      if (int.parse(logDate.substring(8, 10)) ==
                              selectedDate.day &&
                          int.parse(logDate.substring(6, 7)) ==
                              selectedDate.month) {
                        return Column(
                          children: [
                            log,
                            const SizedBox(height: 8.0),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}