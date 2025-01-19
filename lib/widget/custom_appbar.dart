import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_web/providers/theme_provider.dart';

// import 'package:my_web/config/theme/app_theme.dart';
// import 'package:my_web/providers/theme_provider.dart';
// ... Ajusta según tu estructura real

// Asumiendo que ya declaraste listColors y themeNotifyProvider en otro lado.
// Ejemplo de listColors y AppTheme si quieres mantenerlo aquí:
const List<Color> listColors = [
  Color(0xFFE74C3C),
  Color(0xFFF7D794),
  Color(0xFF55E6C1),
  Color(0xFF00CEC9),
  Color(0xFFADD8E6),
  Color(0xFFAF52DE),
];

class CustomAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;
  final double expandedOpacity;
  final double collapsedOpacity;
  final double scrollStart;
  final double scrollEnd;
  final String title;

  const CustomAppBar({
    super.key,
    required this.scrollController,
    this.expandedOpacity = 1.0,
    this.collapsedOpacity = 0.75,
    this.scrollStart = 0.0,
    this.scrollEnd = 100.0,
    this.title = 'Manu Dev',
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  double _currentOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentOffset = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Leemos estado global del tema desde el provider
    final appTheme = ref.watch(themeNotifyProvider);

    // Calculamos la opacidad según el scroll
    final clampedOffset = _currentOffset.clamp(widget.scrollStart, widget.scrollEnd);
    final double percent =
        (clampedOffset - widget.scrollStart) / (widget.scrollEnd - widget.scrollStart);

    final currentOpacity = lerpDouble(
      widget.expandedOpacity,
      widget.collapsedOpacity,
      percent,
    )!;

    // Obtenemos color primario del tema actual
    final backgroundColor = Theme.of(context).primaryColor.withOpacity(currentOpacity);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: GestureDetector(
        onTap: () => context.go("/"),
        child: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.color_lens,),
          color: Colors.white,
          onPressed: () => _showColorPicker(appTheme.selectedColor),
        ),
      ],
      elevation: 0,
    );
  }

  void _showColorPicker(int currentIndex) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _ColorPickerWidget(
          selectedIndex: currentIndex, // Usa directamente el estado global
          onColorSelected: (index) {
            // Cambiamos el color en el provider
            ref.read(themeNotifyProvider.notifier).changeColor(index);

            Navigator.pop(context); // Cerrar bottom sheet
          },
        );
      },
    );
  }
}

class _ColorPickerWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onColorSelected;

  const _ColorPickerWidget({
    Key? key,
    required this.selectedIndex,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = listColors;

    return Container(
      padding: const EdgeInsets.all(16),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Elige un color',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: colors.length,
              itemBuilder: (BuildContext context, int index) {
                final color = colors[index];
                final isSelected = (index == selectedIndex);

                return GestureDetector(
                  onTap: () => onColorSelected(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border:
                          isSelected ? Border.all(color: Colors.black, width: 3) : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
