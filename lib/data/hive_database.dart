import 'package:hive/hive.dart';
import '../models/expense_items.dart';

class HiveDatabase{
  final _mybox = Hive.box("expense_database");

  void saveData(List<ExpenseItems> allExpense){
    List<List<dynamic>> allExpensesFormatted = [];
    for(var expense in allExpense){
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _mybox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  List<ExpenseItems> readData(){
    List savedExpenses = _mybox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItems> allExpenses=[];

    for(int i=0; i<savedExpenses.length;i++){
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItems expense= ExpenseItems(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }

}
// import 'package:hive/hive.dart';
// import '../models/expense_items.dart';
//
// class HiveDatabase {
//   final _mybox = Hive.box("expense_database2");
//
//   void saveData(List<ExpenseItems> allExpense) {
//     List<List<dynamic>> allExpensesFormatted = [];
//     for (var expense in allExpense) {
//       List<dynamic> expenseFormatted = [
//         expense.name,
//         expense.amount,
//         expense.dateTime.toIso8601String(), // Convert DateTime to ISO8601 string
//       ];
//       allExpensesFormatted.add(expenseFormatted);
//     }
//     _mybox.put("ALL_EXPENSES", allExpensesFormatted);
//   }
//
//   List<ExpenseItems> readData() {
//     List savedExpenses = _mybox.get("ALL_EXPENSES") ?? [];
//     List<ExpenseItems> allExpenses = [];
//
//     for (int i = 0; i < savedExpenses.length; i++) {
//       String name = savedExpenses[i][0];
//       String amount = savedExpenses[i][1];
//       DateTime dateTime = DateTime.parse(savedExpenses[i][2]);
//       double? amountAsDouble = double.tryParse(amount);
//       if (amountAsDouble == null) {
//         continue; // Skip invalid amount
//       }
//
//       ExpenseItems expense = ExpenseItems(
//         name: name,
//         amount: amount,
//         dateTime: dateTime,
//       );
//
//       allExpenses.add(expense);
//     }
//     return allExpenses;
//   }
// }
