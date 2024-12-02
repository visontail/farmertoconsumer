import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;

  AnimatedButton({
    required this.text,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300), // Duration of animation
      curve: Curves.easeInOut, // Smooth animation curve
      height: 50, // Fixed height for button
      width: double.infinity, // Ensure it takes full width
      decoration: BoxDecoration(
        color: isLoading ? Colors.grey : Color(0xFF48872B), // Green when not loading, grey when loading
        borderRadius: BorderRadius.circular(6), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Color(0x55000000), // Shadow color with some opacity
            offset: Offset(0, 4), // Shadow position (X, Y)
            blurRadius: 4, // Shadow blur radius
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Disable button when loading
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // No background color (already handled by AnimatedContainer)
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Rounded corners
          ),
          elevation: 0, // No additional elevation needed
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.0, // Fixed size for spinner
                    height: 24.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.0,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Submitting...',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
