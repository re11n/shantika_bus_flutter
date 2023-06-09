import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:shantika_bus/components/ticket_view.dart';
import 'package:shantika_bus/pages/booking_list.dart';
import 'package:shantika_bus/pages/pembayaran.dart';
import '../components/payment_list.dart';
import 'about_us.dart';
import 'jadwal_page.dart';
import 'homepage.dart';
import 'setting_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    SingleChildScrollView(
      child: Column(children: const [HomeScreen(), TicketView()]),
    ),
    const PaymentList(),
    const BookingList(),
    const JadwalPage(),
    AboutUsPage(),
  ];
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Center(
              child: Image.asset(
            'lib/images/shantika_logo.png',
            height: 40,
          )),
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.displayName ?? ''), // or user.email
                accountEmail: Text(user.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  child: Text(user.email![0].toUpperCase(),
                      style: const TextStyle(fontSize: 40.0)),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(child: tabItems[_selectedIndex]),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.house),
              title: const Text('Dashboard'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.payment),
              title: const Text('Payment'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.payment),
              title: const Text('Booking'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.schedule),
              title: const Text('Schedule'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.person_2_outlined),
              title: const Text('About Us'),
            ),
          ],
        ),
      ),
    );
  }
}
