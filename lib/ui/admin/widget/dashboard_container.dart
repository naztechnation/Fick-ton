import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class dashBoardContainer extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color color;
  final Color txtColor;

  final Widget description;

  const dashBoardContainer({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    this.color = Colors.white,
    this.txtColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: txtColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              if (imageUrl != '')
                ImageView.svg(
                  imageUrl,
                  width: 15,
                  height: 15,
                  color: txtColor,
                ),
            ],
          ),
          const SizedBox(height: 10.0),
          description
        ],
      ),
    );
  }
}
