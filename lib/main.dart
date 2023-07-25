import 'package:flutter/material.dart';
import 'package:budget_tracker/Pages/home.dart';
import 'package:budget_tracker/Pages/expensescreen.dart';


void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home( expenses: [
      Expense(amount: -500, expenses: 'Groceries'),
      Expense(amount: -1000, expenses: 'Bills'),
      Expense(amount: 50000, expenses: 'Salary'),
    ]),
    '/expense_screen': (context) => ExpenseScreen(),
  },
));


