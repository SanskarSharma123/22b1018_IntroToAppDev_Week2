import 'package:flutter/material.dart';
import 'package:budget_tracker/Pages/expensescreen.dart';

class Home extends StatefulWidget {
  final List<Expense> expenses;

  Home({required this.expenses});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int calculateTotal() {
    int total = 0;
    for (var expense in widget.expenses) {
      total += expense.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    int total = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: Text(
          'Budget_Tracker',
          style: TextStyle(
            fontSize: 45,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent[100],
      ),
      body: Column(
        children: [
          Center(
            child: Icon(
              Icons.people_alt_sharp,
              color: Colors.black,
              size: 100,
            ),
          ),
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 50,
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Back!',
            style: TextStyle(
              fontSize: 50,
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50),
          Card(
            color: Colors.white,
            margin: EdgeInsets.all(50),
            child: Text(
              'Total : ${total.toString()}',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExpenseScreen(),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 70,
            color: Colors.purpleAccent[100],
          ),
        ),
      ),
    );
  }
}
