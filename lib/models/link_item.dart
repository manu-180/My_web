import 'package:flutter/material.dart';

class LinkItem {
  final String label;        // Texto del botón
  final String destination;  // Ruta interna o URL externa
  final bool isExternal;     // Indica si es un enlace externo
  final IconData? iconData;  // Ícono de font_awesome_flutter u otro

  LinkItem({
    required this.label,
    required this.destination,
    this.isExternal = false,
    this.iconData,
  });
}
