import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  final String label;  // Thêm tham số label
  final VoidCallback onPressed;

  CalculateButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, style: TextStyle(fontSize: 16)), // Sử dụng label
      ),
    );
  }
}
