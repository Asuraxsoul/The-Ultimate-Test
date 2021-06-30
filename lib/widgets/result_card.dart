import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Results {
  String result1 = '';
  String result2 = '';
  String result3 = '';
  String result4 = '';
}

class ConvertedResults {
  int result1 = 0;
  int result2 = 0;
  int result3 = 0;
  int result4 = 0;
  int total = 0;
}

class ResultCard extends StatefulWidget {
  final String title;
  final int result;
  final int total;

  const ResultCard({
    Key? key,
    required this.title,
    required this.result,
    required this.total,
  }) : super(key: key);

  @override
  _ResultCardState createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${widget.title}: ${widget.result} / ${widget.total}'),
        SizedBox(height: 10),
        Container(
          height: 60,
          width: 60,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      positionFactor: 0.1,
                      angle: 90,
                      widget: Text(
                        '${widget.result * 100 / widget.total}%',
                        style: TextStyle(fontSize: 11),
                      ))
                ],
                axisLineStyle: AxisLineStyle(
                  thickness: 0.1,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: (widget.result * 100 / widget.total),
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.startCurve,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0xFF00a9b5), Color(0xFFa4edeb)],
                          stops: <double>[0.25, 0.75])),
                  MarkerPointer(
                    value: (widget.result * 100 / widget.total),
                    markerType: MarkerType.circle,
                    color: const Color(0xFF87e8e8),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
