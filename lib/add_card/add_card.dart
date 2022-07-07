import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ufopayapp/shared/bottom_nav.dart';

import '../services/services.dart';
import '../shared/shared.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String _dropdownValue = "滙豐銀行 現金回饋御璽卡VISA御璽卡";

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CreditCard>>(
      future: FirestoreService().getCards(),
      builder: (context, snapshot) {
        var ufoUserInfo = Provider.of<UfoUserInfo>(context);
        var user = AuthService().user;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var creditCards = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text("新增卡片"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50.0),
                    child: DropdownButton(
                      items: creditCards
                          .map<DropdownMenuItem<String>>((CreditCard mascot) {
                        return DropdownMenuItem<String>(
                            child: Text(mascot.name), value: mascot.name);
                      }).toList(),
                      value: _dropdownValue,
                      onChanged: dropdownCallback,
                      // Customizatons
                      // iconSize: 42.0,
                      // iconEnabledColor: Colors.green,
                      // icon: const Icon(Icons.open_in_browser_sharp),
                      // isExpanded: true,
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Image.network(creditCards
                      .where(
                          (CreditCard mascot) => mascot.name == _dropdownValue)
                      .toList()[0]
                      .imageURL)
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                CreditCard currentCreditCard = creditCards
                    .where((CreditCard mascot) => mascot.name == _dropdownValue)
                    .toList()[0];
                FirestoreService().updateUfoUserInfo(currentCreditCard);
                Navigator.pushReplacementNamed(context, '/profile');
              },
            ),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
