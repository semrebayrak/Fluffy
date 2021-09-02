
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialWidget extends StatelessWidget {
  const SpeedDialWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return SpeedDial(
    /// both default to 16
    marginEnd: size.width*0.05,
    marginBottom: size.height*0.03,
    // animatedIcon: AnimatedIcons.menu_close,
    // animatedIconTheme: IconThemeData(size: 22.0),
    /// This is ignored if animatedIcon is non null
    icon: Icons.add,
    activeIcon: Icons.remove,
    // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),
    /// The label of the main button.
    // label: Text("Open Speed Dial"),
    /// The active label of the main button, Defaults to label if not specified.
    // activeLabel: Text("Close Speed Dial"),
    /// Transition Builder between label and activeLabel, defaults to FadeTransition.
    // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
    /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
    buttonSize: size.width*0.15,
    visible: true,
    /// If true user is forced to close dial manually 
    /// by tapping main button and overlay is not rendered.
    closeManually: false,
    /// If true overlay will render no matter what.
    renderOverlay: false,
    curve: Curves.bounceIn,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
    onOpen: () => print('OPENING DIAL'),
    onClose: () => print('DIAL CLOSED'),
    tooltip: 'Speed Dial',
    heroTag: 'speed-dial-hero-tag',
    backgroundColor: Colors.blue,
    foregroundColor: Colors.blue,
    elevation: 8.0,
    shape: CircleBorder(),
    // orientation: SpeedDialOrientation.Up,
    // childMarginBottom: 2,
    // childMarginTop: 2,
    children: [
      SpeedDialChild(
        child: Icon(Icons.home),
        backgroundColor: Colors.red,
       
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => Navigator.pushNamed(context, 'stay'),
        onLongPress: () => print('FIRST CHILD LONG PRESS'),
      ),
      SpeedDialChild(
        child: Icon(Icons.directions_walk),
        backgroundColor: Colors.blue,
       
        labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => Navigator.pushNamed(context, 'walk'),
        onLongPress: () => print('SECOND CHILD LONG PRESS'),
      ),
      SpeedDialChild(
        child: Icon(Icons.directions_car),
        backgroundColor: Colors.green,
        
        labelStyle: TextStyle(fontSize: 18.0),
       onTap: () => Navigator.pushNamed(context, 'road'),
        onLongPress: () => print('THIRD CHILD LONG PRESS'),
      ),
    ],
    );
  }
}
