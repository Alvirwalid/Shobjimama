import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SreatTotal extends StatefulWidget {
  const SreatTotal({super.key});

  @override
  State<SreatTotal> createState() => _SreatTotalState();
}

class _SreatTotalState extends State<SreatTotal> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        var tut = 0.0;

        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          tut += double.parse(snapshot.data!.docs[i]['price']);
        }

        return Container(
            color: Colors.red,
            width: 150,
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('$tut')],
            ));
      },
    );
  }
}
