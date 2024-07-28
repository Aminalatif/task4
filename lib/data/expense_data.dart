import 'package:flutter/cupertino.dart';
import 'package:untitled3/data/hive_database.dart';
import 'package:untitled3/dateTime/date_time_helper.dart';

import '../models/expense_items.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItems> overallExpenseList = [];

  List<ExpenseItems> getAllExpenseList() {
    return overallExpenseList;
  }

  final db = HiveDatabase();

  void prepareData() {
    if (db
        .readData()
        .isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  void addNewExpense(ExpenseItems newExpense) {
    overallExpenseList.add(newExpense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteNewExpense(ExpenseItems expense) {
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return "";
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    DateTime today = DateTime.now();

    for (int i = 0; i <= 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double? amount = double.tryParse(
          expense.amount); // Use tryParse for safe parsing

      if (amount != null) { // Proceed only if the amount is valid
        if (dailyExpenseSummary.containsKey(date)) {
          dailyExpenseSummary[date] = dailyExpenseSummary[date]! + amount;
        } else {
          dailyExpenseSummary[date] = amount;
        }
      }
    }

    return dailyExpenseSummary;
  }
}
