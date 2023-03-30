import 'package:flutter/material.dart';

class ReampBackButton extends StatelessWidget {
  const ReampBackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0.0),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () => Navigator.of(context).pop(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_back_ios, size: 18),
          Text(
            "Zurück",
            style: Theme.of(context).textTheme.button,
          ),
        ],
      ),
    );
  }
}
