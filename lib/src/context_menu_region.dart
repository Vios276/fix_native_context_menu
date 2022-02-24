import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'method_channel.dart';

class ContextMenuRegion extends StatefulWidget {
  const ContextMenuRegion({
    required this.child,
    required this.menuItems,
    Key? key,
    this.onItemSelected,
    this.onDismissed,
    this.menuOffset = Offset.zero,
  }) : super(key: key);

  final Widget child;
  final List<MenuItem> menuItems;
  final Offset menuOffset;
  final void Function(MenuItem item)? onItemSelected;
  final VoidCallback? onDismissed;

  @override
  _ContextMenuRegionState createState() => _ContextMenuRegionState();
}

class _ContextMenuRegionState extends State<ContextMenuRegion> {
  bool shouldReact = false;
  Duration pressTime = const Duration(milliseconds: 0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      onDoubleTapDown: (e) async {
        print('double tap');
        // final position = Offset(
        //   e.position.dx + widget.menuOffset.dx,
        //   e.position.dy + widget.menuOffset.dy,
        // );
        final position = Offset(
          e.globalPosition.dx + widget.menuOffset.dx,
          e.globalPosition.dy + widget.menuOffset.dy,
        );

        final selectedItem = await showContextMenu(
          ShowMenuArgs(
            MediaQuery.of(context).devicePixelRatio,
            position,
            widget.menuItems,
          ),
        );

        if (selectedItem != null) {
          widget.onItemSelected?.call(selectedItem);
        } else {
          widget.onDismissed?.call();
        }
      },
      child: widget.child,
    );

    // return Listener(
    //   onPointerDown: (e) {
    //     if (e.kind == PointerDeviceKind.mouse && e.buttons == 1) {
    //       print('now :' + e.timeStamp.toString());
    //       print('before :' + pressTime.toString());
    //       print((e.timeStamp.inMilliseconds - pressTime.inMilliseconds)
    //           .toString());
    //       if (e.timeStamp.inMilliseconds - pressTime.inMilliseconds < 500) {
    //         shouldReact = true;
    //       } else {
    //         pressTime = e.timeStamp;
    //       }
    //     }
    //   },
    //   onPointerUp: (e) async {
    //     if (!shouldReact) return;
    //
    //     pressTime = const Duration(milliseconds: 0);
    //     shouldReact = false;
    //
    //     final position = Offset(
    //       e.position.dx + widget.menuOffset.dx,
    //       e.position.dy + widget.menuOffset.dy,
    //     );
    //
    //     final selectedItem = await showContextMenu(
    //       ShowMenuArgs(
    //         MediaQuery.of(context).devicePixelRatio,
    //         position,
    //         widget.menuItems,
    //       ),
    //     );
    //
    //     if (selectedItem != null) {
    //       widget.onItemSelected?.call(selectedItem);
    //     } else {
    //       widget.onDismissed?.call();
    //     }
    //   },
    //   child: widget.child,
    // );
  }
}