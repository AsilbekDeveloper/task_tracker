import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';

class IconDialogWidget extends StatefulWidget {
  final Function(IconData icon) onIconSelected;

  const IconDialogWidget({super.key, required this.onIconSelected});

  @override
  State<IconDialogWidget> createState() => _IconDialogWidgetState();
}

class _IconDialogWidgetState extends State<IconDialogWidget> {
  final List<IconData> icons = [
    Icons.work,
    Icons.school,
    Icons.favorite,
    Icons.home,
    Icons.star,
    Icons.sports_soccer,
    Icons.shopping_cart,
    Icons.pets,
    Icons.flight,
    Icons.music_note,
    Icons.book,
    Icons.fitness_center,
    Icons.local_cafe,
    Icons.directions_car,
    Icons.computer,
    Icons.local_hospital,
    Icons.restaurant,
    Icons.beach_access,
    Icons.camera_alt,
    Icons.cleaning_services,
    Icons.lightbulb,
    Icons.phone_android,
    Icons.science,
    Icons.build,
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        color: Colors.black, // 🔧 Orqa fon rangi qora
        padding: const EdgeInsets.all(16),
        height: 500,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose an Icon",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // 🔧 Matn rangi oq
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: icons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onIconSelected(icons[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade800, // 🔧 Orqa fon: qoramtir
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        icons[index],
                        size: 32,
                        color: Colors.white, // 🔧 Icon rangi oq
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
