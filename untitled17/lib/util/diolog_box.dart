import 'package:flutter/material.dart';
import 'package:untitled17/util/my_button.dart';

class DiologBox extends StatelessWidget {
  DiologBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[100],
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new Task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: 'Save',
                  onpressed: onSave,
                ),
                const SizedBox(width: 8),
                MyButton(
                  text: 'Cancel',
                  onpressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
