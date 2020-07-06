import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:wondersappver02/models/inspection.dart';
import 'package:wondersappver02/util/dialog_util.dart' as dialogUtil;

class Touch extends StatefulWidget {
  @override
  _TouchState createState() => _TouchState();
}

class _TouchState extends State<Touch> {

  final Set<int> selectedIndexes = Set<int>();
  final key = GlobalKey();
  final Set<_TouchItem> _trackTaped = Set<_TouchItem>();

  _detectTapedItem(PointerEvent event) {
    final RenderBox box = key.currentContext.findRenderObject();
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        /// temporary variable so that the [is] allows access of [index]
        final target = hit.target;
        if (target is _TouchItem && !_trackTaped.contains(target)) {
          _trackTaped.add(target);
          _selectIndex(target.index);
          if(selectedIndexes.length == 40){
            Provider.of<Inspection>(context).setTouch('success');
            dialogUtil.showToast(context, true, Colors.black);
          }else{
            Provider.of<Inspection>(context).setTouch('fail');
          }
        }
      }
    }
  }

  _selectIndex(int index) {
    setState(() {
      selectedIndexes.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = ((size.width) / 5) + 7;
    final double itemHeight = ((size.height) / 8) + 4;
    return Listener(
      onPointerDown: _detectTapedItem,
      onPointerMove: _detectTapedItem,
//      onPointerUp: _clearSelection,
      child: GridView.builder(
        key: key,
        itemCount: 40,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemBuilder: (context, index) {
          return TouchItem(
            index: index,
            child: Container(
              color: selectedIndexes.contains(index) ? Colors.redAccent : Colors.cyan,
            ),
          );
        },
      ),
    );
  }

  void _clearSelection(PointerUpEvent event) {
    _trackTaped.clear();
    setState(() {
      selectedIndexes.clear();
    });
  }
}

class TouchItem extends SingleChildRenderObjectWidget {
  final int index;

  TouchItem({Widget child, this.index, Key key}) : super(child: child, key: key);

  @override
  _TouchItem createRenderObject(BuildContext context) {
    return _TouchItem()..index = index;
  }

  @override
  void updateRenderObject(BuildContext context, _TouchItem renderObject) {
    renderObject..index = index;
  }
}

class _TouchItem extends RenderProxyBox {
  int index;
}