import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        '₹ ${transactions[index].amount}',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: MediaQuery.of(context).size.width > 460
                    ? TextButton.icon(
                        onPressed: () => deleteTx(transactions[index].id),
                        icon: Icon(Icons.delete),
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        label: Text('Delete'),
                      )
                    : IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
              ));
          // return Card(
          //   child: Row(
          //     children: <Widget>[
          //       Container(
          //         margin:
          //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //             color: Theme.of(context).primaryColor,
          //             width: 2,
          //           ),
          //         ),
          //         padding: EdgeInsets.all(10),
          //         child: Text(
          //           '₹ ' + transactions[index].amount.toStringAsFixed(2),
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //         ),
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text(
          //             transactions[index].title,
          //             style: TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           Text(
          //             DateFormat.yMMMd().format(transactions[index].date),
          //             //tx.date.toString(),
          //             style: TextStyle(
          //               color: Colors.grey,
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // );
        },
        // Iterates above code till this number of times
        itemCount: transactions.length,
      ),
    );
  }
}
