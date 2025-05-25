import 'package:flutter/material.dart';

class ReconnectWidget extends StatefulWidget {
  const ReconnectWidget({
    super.key,
    required this.onReconnect,
  });

  final Function() onReconnect;

  @override
  State<ReconnectWidget> createState() => _ReconnectWidgetState();
}

class _ReconnectWidgetState extends State<ReconnectWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onReconnect,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'connection error',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
              child: const Text(
                'retry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
