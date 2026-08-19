import 'package:flutter/material.dart';
import 'package:questlog/widgets/section_decoration.dart';

class ActiveProtocol extends StatelessWidget {
  const ActiveProtocol({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: EdgeInsets.all(10),
      decoration: SectionDecoration(),
    );
  }
}
