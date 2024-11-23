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
    quantity = widget.initialValue; // Initialize with the given initial value
  }

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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          ),
          onPressed: _decrement,
          child: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '$quantity',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          ),
          onPressed: _increment,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
