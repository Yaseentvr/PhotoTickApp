import 'package:flutter/material.dart';

class noEventAdded_text extends StatelessWidget {
  const noEventAdded_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 30, color: Colors.grey),
          SizedBox(height: 10),
          Text('No Events Added', style: TextStyle(fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
