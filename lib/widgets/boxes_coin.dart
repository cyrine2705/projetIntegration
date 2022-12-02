import 'package:flutter/material.dart';

class BoxCoins extends StatefulWidget {
  final String image;
  final String text;
  final String text1;
  const BoxCoins(
      {Key? key, required this.image, required this.text, required this.text1})
      : super(key: key);

  @override
  State<BoxCoins> createState() => _BoxCoinsState();
}

class _BoxCoinsState extends State<BoxCoins> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(widget.image),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Text(widget.text),
          ),
          Text(widget.text1)
        ],
      ),
    );
  }
}
