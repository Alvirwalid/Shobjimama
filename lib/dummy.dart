import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Dummy extends StatefulWidget {
  Dummy({super.key, required this.total});

  double total;

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${widget.total}'),
    );
  }
}
