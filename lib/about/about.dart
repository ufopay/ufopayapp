import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ufopayapp/shared/shared.dart';
import 'package:ufopayapp/services/services.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CreditCard>>(
      future: FirestoreService().getCards(),
      builder: (context, snapshot) {
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
              title: const Text('首頁'),
            ),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: creditCards
                  .map((creditCard) => CreditCardItem(creditCard: creditCard))
                  .toList(),
            ),
            bottomNavigationBar: const BottomNavBar(),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}

class CreditCardItem extends StatelessWidget {
  final CreditCard creditCard;
  const CreditCardItem({super.key, required this.creditCard});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: creditCard.name,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    CreditCardScreen(creditCard: creditCard),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.network(
                    creditCard.imageURL,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    creditCard.name,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCardScreen extends StatelessWidget {
  final CreditCard creditCard;

  const CreditCardScreen({super.key, required this.creditCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: creditCard.name,
            child: Image.network(creditCard.imageURL,
                width: MediaQuery.of(context).size.width),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              creditCard.name,
              style: const TextStyle(
                  height: 2, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: creditCard.features
                .map((el) => Container(
                        child: ListTile(
                      title: Text(el),
                      leading: Icon(Icons.star),
                    )))
                .toList(),
          ),
        ],
      ),
    );
  }
}
