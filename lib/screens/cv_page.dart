import 'package:flutter/material.dart';
import 'package:my_web/widget/custom_appbar.dart';

class CVPage extends StatelessWidget {
  const CVPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    
    return Scaffold(
      
      appBar: CustomAppBar(scrollController: scrollController),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: Image.asset(
            'assets/images/cvv.jpeg', 
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
