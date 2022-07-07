import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ufopayapp/services/auth.dart';
import 'package:ufopayapp/services/models.dart';
import 'package:ufopayapp/services/services.dart';
import 'package:ufopayapp/shared/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:ufopayapp/shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('帳戶資訊'),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("你好，${user.uid}")),
              const Divider(),
              ProfileCards(user: user),
              const Divider(),
              ElevatedButton(
                child: const Text('登出'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
    } else {
      return const Loader();
    }
  }
}

class ProfileCards extends StatelessWidget {
  const ProfileCards({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getUfoUserInfo(user?.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UfoUserInfo userInfo = snapshot.data! as UfoUserInfo;
            if (userInfo.cardnames.length == 0) {
              return const Text("目前沒有卡片");
            }
            return Expanded(
              child: ListView(
                  children: userInfo.cardnames
                      .map((el) => Dismissible(
                          child: ListTile(
                            title: Text(el),
                            leading: Icon(Icons.credit_card),
                          ),
                          key: Key(el),
                          onDismissed: (direction) {
                            userInfo.cardnames.remove(el);
                            FirestoreService().deleteUfoUserInfo(el);
                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('已刪除 $el')));
                          },
                          background: Container(
                              child: Icon(Icons.delete), color: Colors.red)))
                      .toList()),
            );
          } else {
            return const Text("目前沒有卡片");
          }
        });
  }
}
