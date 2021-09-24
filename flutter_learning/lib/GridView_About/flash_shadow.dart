
import 'package:flutter/material.dart';

///这个类通过显示动画能实现闪烁阴影的效果
///This class can achieve the effect of flickering shadows by explicit animations

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  final DecorationTween decorationTween = DecorationTween(
    begin:
    BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: Colors.teal[200],
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 20.0,
            spreadRadius: 3.0,
            offset: Offset(0, 6.0),
          ),

        ])
    ,
    end: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: Colors.teal[200],
        boxShadow: [
          BoxShadow(
            color: Color(0xffffd770),
            blurRadius: 20.0,
            spreadRadius: 3.0,
            offset: Offset(0, 6.0),
          ),

        ]),
  );

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: DecoratedBoxTransition(
          position: DecorationPosition.background,
          decoration: decorationTween.animate(_controller),
          child: Container(
            width: 200,
            height: 200,
            padding: const EdgeInsets.all(10),
            child: const FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
