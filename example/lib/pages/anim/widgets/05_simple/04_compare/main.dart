import 'package:example/pages/anim/widgets/05_simple/04_compare/toggle_rotate.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';

/// 进度条控制旋转的下限
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  ValueNotifier<double> angle = ValueNotifier<double>(90);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: ValueListenableBuilder(
          valueListenable: angle,
          builder: (_, value, __) => Wrap(
            alignment: WrapAlignment.center,
            children: [
              Slider(
                  value: value,
                  min: 0,
                  max: 360,
                  onChanged: (v) {
                    Logger.d('$v');
                    angle.value = v;
                  }),
              ToggleRotate(
                beginAngle: 0,
                endAngle: value,
                curve: Curves.ease,
                child: const Image(
                    width: 60,
                    height: 60,
                    image: AssetImage("assets/images/icon_head.jpg")),
                onEnd: (v) {
                  print("---expanded---:$v-------");
                },
                onTap: () {
                  print("---tap----------");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
