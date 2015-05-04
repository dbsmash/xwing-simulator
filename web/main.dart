library xwing;

import "dart:math";
import 'dart:html';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart';

part 'dice.dart';
part 'constants.dart';
part 'simulation_panel.dart';

// main just wires up the button listeners to start an attack simulation
void main() {
    reactClient.setClientConfiguration();
    render(SimulationPanel({}), querySelector('#content'));
}
