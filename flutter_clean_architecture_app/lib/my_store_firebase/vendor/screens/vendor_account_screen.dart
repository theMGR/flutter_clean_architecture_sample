import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flearn/my_store_firebase/views/screens/authentication_screens/login_screen.dart';

class VendorAccountScreen extends StatelessWidget {
  const VendorAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('vendors');

    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('storeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(data['storeImage']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hi ' + data['companyName'],
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 4,
                        ),
                      ),
                    )
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut().whenComplete(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        });
                      },
                      icon: Icon(
                        Icons.logout,
                      ),
                    ),
                  ),
                ],
              ),
              body: StreamBuilder<QuerySnapshot>(
                stream: _ordersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }

                  double totalOrder = 0.0;
                  for (var orderItem in snapshot.data!.docs) {
                    totalOrder += orderItem['quantity'] * orderItem['price'];
                  }
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Color(0xFF102DE1),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'TOTAL EARNINGS',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '\$' + " " + totalOrder.toStringAsFixed(2),
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'TOTAL ORDERS',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  snapshot.data!.docs.length.toString(),
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (context) {
                        //       return WithdrawalScreen();
                        //     }));
                        //   },
                        //   child: Container(
                        //     height: 40,
                        //     width: MediaQuery.of(context).size.width - 40,
                        //     decoration: BoxDecoration(
                        //       color: Colors.yellow.shade900,
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'WithDraw',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.bold,
                        //           letterSpacing: 6,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ));
                },
              ));
        }

        return Center(
            child: CircularProgressIndicator(
          color: Colors.yellow.shade900,
        ));
      },
    );
  }
}
