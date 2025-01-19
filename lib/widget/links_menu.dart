import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_web/models/link_item.dart';

class LinksMenu extends StatelessWidget {
  final List<LinkItem> items;

  const LinksMenu({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((link) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: double.infinity, // Botón ocupa todo el ancho
            child: ElevatedButton(
              onPressed: () async {
                if (link.isExternal) {
                  final uri = Uri.parse(link.destination);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No se pudo abrir: ${link.destination}')),
                    );
                  }
                } else {
                  context.push(link.destination);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Si hay iconData, mostramos el FaIcon
                  if (link.iconData != null) ...[
                    FaIcon(
                      link.iconData,
                      color: Theme.of(context).colorScheme.primary, 
                      size: 20, // Ajusta el tamaño a tu gusto
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(link.label),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
