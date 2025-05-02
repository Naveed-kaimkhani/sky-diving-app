import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final Function(T?)? onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.selectedItem,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    // Select the first item by default if none is selected
    _selectedItem = widget.selectedItem ?? (widget.items.isNotEmpty ? widget.items[0] : null);
    // Call onChanged callback if no selected item is provided
    if (widget.selectedItem == null && widget.items.isNotEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        widget.onChanged?.call(widget.items[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: InputDecorator(
          decoration: InputDecoration(
            filled: true,
            hintText: "Select an option", // <-- Your placeholder text
            hintStyle: TextStyle(color: Colors.white),
            fillColor: AppColors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedItem?.toString() ?? '',
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5,
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(0, size.height + 5),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: widget.items.map((item) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItem = item;
                        });
                        widget.onChanged?.call(item);
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.toString(),
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}