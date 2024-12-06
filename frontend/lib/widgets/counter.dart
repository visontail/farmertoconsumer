import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final void Function(int value)? onChanged;

  const Counter({Key? key, this.initialValue = 1, required this.maxValue, this.onChanged}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
  }

  int get currentQuantity => quantity; // Getter for quantity

  void _increment() {
    if (quantity < widget.maxValue) {
      setState(() {
        quantity++;
      });
      if (widget.onChanged != null) widget.onChanged!(quantity);
    }
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      if (widget.onChanged != null) widget.onChanged!(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
        width: 27,
        height: 27,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: gray,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          onPressed: _decrement,
          child: const Icon(Icons.remove, size: 12),
          ),
        ),
        SizedBox(
          width: 27,
          height: 27,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: gray,
                width: 1,
              ),
            ),
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
        SizedBox(
        width: 27,
        height: 27,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: gray,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          onPressed: _increment,
          child: const Icon(Icons.add, size: 12),
        ),
      ),
      ],
    );
  }
}

