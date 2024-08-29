import 'package:getx_scaffold/common/index.dart';

class TapDemo extends StatelessWidget {
  const TapDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      onTapUp: _onTapUp,
    );
  }

  void _onTap() {
    Logger.d('-----_onTap---------', 'touch');
  }

  void _onTapDown(TapDownDetails details) {
    Logger.d('-----_onTapDown----${details.globalPosition}-----', 'touch');
    Logger.d('-----_onTapDown----${details.localPosition}-----', 'touch');
    Logger.d('-----_onTapDown----${details.kind}-----', 'touch');
  }

  void _onTapCancel() {
    Logger.d('-----_onTapCancel---------', 'touch');
  }

  void _onTapUp(TapUpDetails details) {
    Logger.d('-----_onTapUp---${details.localPosition}------', 'touch');
    Logger.d('-----_onTapUp---${details.globalPosition}------', 'touch');
    Logger.d('-----_onTapUp---${details.kind}------', 'touch');
  }
}
