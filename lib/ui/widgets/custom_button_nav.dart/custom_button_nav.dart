import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/items.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label});
  String icon;
  String selectedIcon;
  String label;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({Key? key,
    required this.items,
    this.centerItemText,
    this.height= 80.0,
    this.iconHeight=24.0,
    this.iconWidth = 24.0,
    this.selectedIconHeight=26.0,
    this.selectedIconWidth=26.0,
    this.fontSize=12.0,
    this.selectedFontSize=14.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) : super(key: key) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String? centerItemText;
  final double height;
  final double iconHeight;
  final double iconWidth;
  final double selectedIconHeight;
  final double selectedIconWidth;
  final double selectedFontSize;
  final double fontSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;


  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageIndexProvider = Provider.of<PageIndexProvider>(context);

    List<Widget> items = List.generate(
        widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      notchMargin: 3.0,
      color: widget.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      )
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconHeight,
                width: widget.iconWidth),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {

    final color = _selectedIndex == index ? widget.selectedColor : widget.color;
    final iconHeight = _selectedIndex == index ? widget.selectedIconHeight : widget.iconHeight;
    final iconWidth = _selectedIndex == index ? widget.selectedIconWidth : widget.iconWidth;
    final fontSize = _selectedIndex == index ? widget.selectedFontSize : widget.fontSize;
    final icon=_selectedIndex == index ? item.selectedIcon : item.icon;

    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            splashFactory: NoSplash.splashFactory,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(icon,
                  color: color,
                  height: iconHeight,
                  width: iconWidth),
                Text(
                  item.label,
                  style: TextStyle(color: color,
                      fontSize: fontSize),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}