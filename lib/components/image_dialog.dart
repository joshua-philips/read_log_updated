import 'package:flutter/material.dart';

class NetworkImageDialog extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;
  const NetworkImageDialog(
      {Key? key, required this.imageUrl, required this.imageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(
              imageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null
                  ? child
                  : Center(
                      child: Text(
                        imageTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
        ),
      ),
    );
  }
}
