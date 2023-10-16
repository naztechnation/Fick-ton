import 'package:flutter/material.dart';

Widget filterModalContent(
    {required String title,
    required List<String> filterItems,
    required BuildContext context,
    required Function(String item) onPressed}) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
            itemCount: filterItems.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () {
                  onPressed(filterItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Center(
                    child: Text(
                      filterItems[index],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              );
            }),
      ],
    ),
  );
}
