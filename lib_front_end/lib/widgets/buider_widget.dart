import 'package:flutter/material.dart';

class BuilderFuture<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const BuilderFuture({
    required this.future,
    required this.builder,
  });

  @override
  _BuilderFutureState<T> createState() => _BuilderFutureState<T>();
}

class _BuilderFutureState<T> extends State<BuilderFuture<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: widget.builder,
    );
  }
}
