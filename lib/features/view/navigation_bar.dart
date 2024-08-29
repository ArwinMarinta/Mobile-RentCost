import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  const CustomNavigationBar({required this.selectedIndex, super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  void _onItemTapped(int index) {
    if (index == widget.selectedIndex) {
      return;
    }
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/category');
        break;
      case 2:
        context.go('/shop');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 12,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(FontAwesome.house_chimney_solid, 'Beranda', 0),
          _buildNavItem(FontAwesome.list_solid, 'Kategori', 1),
          _buildNavItem(FontAwesome.cart_shopping_solid, 'Keranjang', 2),
          _buildNavItem(FontAwesome.user_plus_solid, 'Pengaturan', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = widget.selectedIndex == index;
    return TextButton(
      onPressed: () => _onItemTapped(index),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 20), // Adjust height as needed
        foregroundColor: isSelected ? const Color(0xFF881FFF) : Colors.grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF881FFF) : Colors.grey),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF881FFF) : Colors.grey,
              fontSize: 14, // Set font size here
            ),
          ),
        ],
      ),
    );
  }
}
