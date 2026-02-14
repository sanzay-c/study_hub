import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/core/network/internet/cubit/connectivity_cubit.dart';
import 'package:study_hub/core/network/internet/screens/no_internet_screen.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityOffline) {
          return NoInternetScreen();
        }
        
        return child;
      },
    );
  }
}