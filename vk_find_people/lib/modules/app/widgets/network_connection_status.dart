import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectionStatus extends StatefulWidget {
  final Widget? child;

  const NetworkConnectionStatus({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  _NetworkConnectionStatusState createState() =>
      _NetworkConnectionStatusState();
}

class _NetworkConnectionStatusState extends State<NetworkConnectionStatus> {
  Widget? get child => widget.child;

  late final StreamSubscription _subscription;

  final _networkStatus = ValueNotifier<ConnectivityResult?>(null);

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _networkStatus.value = result;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        if (child != null) Positioned.fill(child: child!),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _networkStatus,
            builder: (context, ConnectivityResult? value, child) {
              const placeholder = SizedBox();
              if (value == null) return placeholder;
              return value == ConnectivityResult.none ? child! : placeholder;
            },
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  // SizedBox(
                  //   width: 60.0,
                  //   height: 60.0,
                  //   child: FittedBox(
                  //     child:
                  //     Lottie.asset('assets/lottie/connection-error.json'),
                  //   ),
                  // ),
                  const SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Check your internet connection',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}