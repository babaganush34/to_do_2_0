import 'package:flutter/material.dart';

class Note {
  final String title;
  final String? content;
  final Color color;

  Note({
    required this.title,
    this.content,
    required this.color,
  });
}

class AddPage extends StatefulWidget {
  final Note? note;

  const AddPage({super.key, this.note});

  @override
  State<AddPage> createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  final List<Note> notes = [];
  final Color colorPurple = const Color(0xFFE1BEE7);
  final Color colorGreen = const Color.fromARGB(255, 37, 133, 34);
  final Color colorBlue = const Color(0xFFE1F5FE);
  final Color colorYellow = const Color(0xFFFFF9C4);
  final Color colorRed = const Color.fromARGB(255, 255, 0, 38);
  final Color colorBrown = const Color.fromARGB(255, 169, 120, 102);
  late List<Color> colors;

  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    colors = [colorPurple, colorGreen, colorBlue, colorYellow, colorRed, colorBrown];
    selectedColor = colorPurple;
    titleController = TextEditingController(text: widget.note?.title ?? "");
    contentController = TextEditingController(text: widget.note?.content ?? "");
    selectedColor = widget.note?.color ?? colorPurple;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("New Note"),
        backgroundColor: const Color.fromARGB(255, 118, 118, 118),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: "Write a title...",
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.black,),
            const SizedBox(height: 5),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: "Write a note...",
                  border: InputBorder.none,
                ),
              ),
            ),

            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Choose Note Color:",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () => setState(() => selectedColor = color),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor == color
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        if (selectedColor == color)
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Navigator.of(context).pop(
                    Note(
                      title: titleController.text,
                      content: contentController.text.isEmpty
                          ? null
                          : contentController.text,
                      color: selectedColor,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Add a title to the note.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: selectedColor,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
              ),
              child: const Text(
                "Save",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}