import 'package:flutter/material.dart';
import 'package:budget_tracker/Pages/home.dart';


class ExpenseScreen extends StatefulWidget {
  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expenses = [
    Expense(amount: -500, expenses: 'Groceries'),
    Expense(amount: -1000, expenses: 'Bills'),
    Expense(amount: 50000, expenses: 'Salary'),
  ];
  bool showRemainingExpenses = false;

  int calculateTotal() {
    int total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  Widget expenseTemplate(Expense expense, {required VoidCallback delete}) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Row(
        children: [
          Text(
            expense.expenses,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 65),
          Text(
            expense.amount.toString(),
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            onPressed: delete,
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showExpenseDialog(BuildContext context) async {
    TextEditingController expenseController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: expenseController,
                decoration: InputDecoration(
                  labelText: 'Expense',
                ),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String expense = expenseController.text;
                int amount = int.tryParse(amountController.text) ?? 0;
                if (expense.isNotEmpty && amount != 0) {
                  setState(() {
                    expenses.add(Expense(expenses: expense, amount: amount));
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: const Text(
          'Budget_Tracker',
          style: TextStyle(
            fontSize: 45.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent[100],
      ),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(50),
            child: Row(
              children: [
                const Text(
                  'Total: ',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 65),
                Text(
                  total.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showRemainingExpenses = !showRemainingExpenses;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          if (showRemainingExpenses)
            ...expenses.map(
                  (expense) => expenseTemplate(
                expense,
                delete: () {
                  setState(() {
                    expenses.remove(expense);
                  });
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showExpenseDialog(context);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.purpleAccent,
        ),
      ),
    );
  }
}

class Expense {
  final String expenses;
  final int amount;

  Expense({required this.expenses, required this.amount});
}
