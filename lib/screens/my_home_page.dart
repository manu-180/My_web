import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_web/models/link_item.dart';
import 'package:my_web/widget/about_me.dart';
import 'package:my_web/widget/custom_appbar.dart';
import 'package:my_web/widget/links_menu.dart';
import 'package:my_web/widget/presentation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();


final List<LinkItem> myLinks = [
  LinkItem(
    label: 'Instagram',
    destination: 'https://www.instagram.com/_manunv/',
    isExternal: true,
    iconData: FontAwesomeIcons.instagram, // <= Aquí el ícono
  ),
  LinkItem(
    label: 'LinkedIn',
    destination: 'https://www.linkedin.com/in/manuel-navarro-b256b52b4/',
    isExternal: true,
    iconData: FontAwesomeIcons.linkedin,
  ),
  LinkItem(
  label: 'Gmail',
  destination: 'mailto:manunv97@gmail.com?subject=Consulta%20desde%20la%20Web&body=Hola!%20Me%20gustaria%20que%20desarrolles%20mi%20aplicacion%20y%20pagina%20web!',
  isExternal: true,
  iconData: FontAwesomeIcons.google
),
  LinkItem(
    label: 'Ver mi CV',
    destination: '/cv',  
    isExternal: false,
    iconData: FontAwesomeIcons.fileLines 
  ),
  
  

];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        scrollController: _scrollController,
        expandedOpacity: 1.0,
        collapsedOpacity: 0.3,
        scrollStart: 0.0,
        scrollEnd: 200.0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              size.width * 0.05, 
              size.height * 0.025, 
              size.width * 0.05, 
              0
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.05),
                  child: Column(
                    children: [
                      Presentation(),
                      AboutMe(),
                      SizedBox(height: size.height * 0.05,),
                      LinksMenu(items: myLinks),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
