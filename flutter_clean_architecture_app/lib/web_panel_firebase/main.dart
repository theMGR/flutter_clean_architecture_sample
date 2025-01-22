import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flearn/web_panel_firebase/views/screens/inner_screens/buyers_screen.dart';
import 'package:flearn/web_panel_firebase/views/screens/inner_screens/category_screen.dart';
import 'package:flearn/web_panel_firebase/views/screens/inner_screens/order_scree.dart';
import 'package:flearn/web_panel_firebase/views/screens/inner_screens/upload_banner_screen.dart';
import 'package:flearn/web_panel_firebase/views/screens/upload_product_screen.dart';
import 'package:flearn/web_panel_firebase/views/screens/vendors_screen.dart';



/*const firebaseConfig = {
  apiKey: "AIzaSyAWI1L6JBWjkULDu9aZlElxcCZ6C3f0IHg",
  authDomain: "flearn-de6f4.firebaseapp.com",
  projectId: "flearn-de6f4",
  storageBucket: "flearn-de6f4.firebasestorage.app",
  messagingSenderId: "1030901590698",
  appId: "1:1030901590698:web:1db2042fe11c58646ffed3",
  measurementId: "G-FV0K1XC7SK"
};*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //name: 'flearn',
      options: kIsWeb || Platform.isAndroid
          ? FirebaseOptions(
              apiKey: "AIzaSyAWI1L6JBWjkULDu9aZlElxcCZ6C3f0IHg",
              appId: '1:1030901590698:web:1db2042fe11c58646ffed3',
              messagingSenderId: '1030901590698',
              projectId: 'flearn-de6f4',
              storageBucket: "flearn-de6f4.firebasestorage.app",
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SideMenu(),
    );
  }
}

class SideMenu extends StatefulWidget {
  static const String id = '\sideMenu';

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = CategoryScreen();

  screnSelectore(item) {
    switch (item.route) {
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });

      case VendorsScreen.routeName:
        setState(() {
          _selectedScreen = VendorsScreen();
        });

        break;

      case BuyersScreen.routeName:
        setState(() {
          _selectedScreen = BuyersScreen();
        });

        break;

      case OrderScreen.routeName:
        setState(() {
          _selectedScreen = OrderScreen();
        });

        break;

      case UploadBanners.id:
        setState(() {
          _selectedScreen = UploadBanners();
        });

        break;

      case ProductUploadPage.id:
        setState(() {
          _selectedScreen = ProductUploadPage();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF3C55EF),
        title: const Text(
          'Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.routeName,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: BuyersScreen.routeName,
            icon: CupertinoIcons.person,
          ),
          // AdminMenuItem(
          //   title: 'Withdrawal',
          //   route: WithrawalScreen.id,
          //   icon: CupertinoIcons.money_dollar,
          // ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.routeName,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category_rounded,
            route: CategoryScreen.id,
          ),

          AdminMenuItem(
            title: 'Upload Banner',
            icon: CupertinoIcons.add,
            route: UploadBanners.id,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: CupertinoIcons.shopping_cart,
            route: ProductUploadPage.id,
          ),
        ],
        selectedRoute: CategoryScreen.id,
        onSelected: (item) {
          screnSelectore(item);

          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black,
          child: const Center(
            child: Text(
              'Multi Store Admin ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedScreen,
    );
  }
}
