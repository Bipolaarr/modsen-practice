import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnimatedCoinChart extends StatefulWidget {
  final List<FlSpot> chartData;
  final bool isPositive;
  final String timeframe;

  const AnimatedCoinChart({
    super.key,
    required this.chartData,
    required this.isPositive,
    required this.timeframe,
  });

  @override
  State<AnimatedCoinChart> createState() => _AnimatedCoinChartState();
}

class _AnimatedCoinChartState extends State<AnimatedCoinChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<FlSpot> _spots = [];
  List<LineChartBarData> _animatedBars = [];

  @override
  void initState() {
    super.initState();
    _spots = widget.chartData;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: (_spots.length - 1).toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          _animatedBars = _buildAnimatedBars();
        });
      });
    _controller.forward();
  }

  List<LineChartBarData> _buildAnimatedBars() {
    final idx = _animation.value;
    final count = idx.floor();
    final next = idx.ceil();
    final percent = idx - count;
    final displayed = _spots.sublist(0, count + 1);
    
    if (next < _spots.length) {
      final interp = FlSpot(
        lerpDouble(_spots[count].x, _spots[next].x, percent)!,
        lerpDouble(_spots[count].y, _spots[next].y, percent)!,
      );
      displayed.add(interp);
    }
    
    final color = widget.isPositive ? Colors.green : Colors.red;
    return [
      LineChartBarData(
        spots: displayed,
        isCurved: false,
        color: color,
        barWidth: 3,
        dotData: const FlDotData(show: false),
      )
    ];
  }

  @override
  void didUpdateWidget(covariant AnimatedCoinChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chartData != widget.chartData) {
      _spots = widget.chartData;
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: _spots.isNotEmpty ? _spots.first.x : 0,
            maxX: _spots.isNotEmpty ? _spots.last.x : 0,
            minY: _spots.map((s) => s.y).reduce((a, b) => a < b ? a : b),
            maxY: _spots.map((s) => s.y).reduce((a, b) => a > b ? a : b),
            lineBarsData: _animatedBars,
          ),
        ),
      ),
    );
  }
}