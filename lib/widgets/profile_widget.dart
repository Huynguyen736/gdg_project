import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.imagePath, required this.onClicked});
  final String imagePath;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
          children: [
            buildImage(),
            Positioned(
                bottom: 0,
                right: 4,
                child: buildEditIcon(color)),
          ]),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
            image: image,
        fit: BoxFit.cover,
        width: 128,
        height: 128,
        child: InkWell(onTap: onClicked,),),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3.0,
    child: buildCircle(
      color: Colors.blue,
      all: 8.0,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({required Color color, required all, required child}) => ClipOval(
    child: Container(
      color: color,
      padding: EdgeInsets.all(all),
      child: child,
    ),
  );
}
