import 'dart:async';
import 'package:device_run_test/src/constants/colors.dart';
import 'package:device_run_test/src/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'online_banking_option.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Payment Screen',
//       home: PaymentScreen(),
//     );
//   }
// }

class PaymentScreen extends StatefulWidget {
  final double totalPrice;

  const PaymentScreen({super.key, required this.totalPrice});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const maxSeconds = 10 * 60;
  int seconds = maxSeconds;

  //Payment Timer
  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Back Button & Countdown Timer
      appBar: AppBar(
        actions: <Widget>[
          OutlinedButton(
              onPressed: () {},
              child: Text(
                '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(cDefaultSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Total Cost & Order Number
            Text(
              'RM ${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 50.0, color: AppColors.cBlueColor2),
            ),
            Text(
              'Order Number: #906912',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40.0,),
            Text(
              'Please select your payment method',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30.0,),
            //List of Payment Method
            ListTile(
              leading: const Icon(Icons.account_balance_outlined),
              title: Text(
                'Online Banking',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // Handle Online Banking tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BankSelectionScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: Text(
                'E-Wallet',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // Handle E-Wallet tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BankSelectionScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: Text(
                'Credit / Debit Card',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // Handle Credit / Debit Card tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BankSelectionScreen()),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
