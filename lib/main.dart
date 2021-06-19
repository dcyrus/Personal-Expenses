import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  //getter is used for accessing some element / read
  List<Transaction> get _recentTransactions {
    //.where() looks for every element in the list and whichever fulfils the conditions is put in the new list (returned one),
    // others are dropped. tx is the input given to where method, as where traverse to each element in the list, it gets the
    // element as input.
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //  Add transaction to list _userTransactions
  void _addNewTransaction(
      String txTitle, double tXAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: tXAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //  Starts the process of adding the transaction : Shows that floating sheet to add input
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          // NewTransaction has whole UI for accepting inputs from user
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.65,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: _userTransactions.isEmpty
                    ? Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            'assets/images/no_expenses.png',
                            scale: 1.0,
                          ),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          if (isLandscape)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Show chart'),
                                Switch(
                                  value: _showChart,
                                  onChanged: (val) {
                                    setState(() {
                                      _showChart = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          if (!isLandscape)
                            Container(
                              height: (MediaQuery.of(context).size.height -
                                      appBar.preferredSize.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.35,
                              child: Chart(_recentTransactions),
                            ),
                          if (!isLandscape) txListWidget,
                          if (isLandscape)
                            _showChart
                                ? Container(
                                    height:
                                        (MediaQuery.of(context).size.height -
                                                appBar.preferredSize.height -
                                                MediaQuery.of(context)
                                                    .padding
                                                    .top) *
                                            0.35,
                                    child: Chart(_recentTransactions),
                                  )
                                : txListWidget,
                        ],
                      )),
            // Show whole list of transactions
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // calls for modal sheet
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
