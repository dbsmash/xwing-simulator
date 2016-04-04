import "dart:math";
import 'dart:html';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart';

import 'package:xwing/xwing.dart';

// main just wires up the button listeners to start an attack simulation
void main() {
  reactClient.setClientConfiguration();
  render(SimulationPanel({}), querySelector('#content'));
}
