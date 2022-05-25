import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_wallet/shared/connectivity_cubit/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityInitialState>{
  ConnectivityCubit():super(ConnectivityInitialState());
  static ConnectivityCubit get(context)=>BlocProvider.of(context);
final _connectivity=Connectivity();
bool? hasConnection;
Future <void>initializeConnectivity()async{
  // _connectivity.onConnectivityChanged.listen(_connectionChange);
  // _checkConnection(await _connectivity.checkConnectivity());
}
// void _connectionChange(ConnectivityResult result){
//   _checkConnection(result);
//
// }
//   Future<bool?> _checkConnection(ConnectivityResult result) async {
//     if (result == ConnectivityResult.none) {
//       hasConnection = false;
//       _connectionChangeController(hasConnection!);
//
//       return hasConnection;
//     }
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         hasConnection = true;
//         _connectionChangeController(hasConnection!);
//       } else {
//         if (hasConnection == null) {
//           hasConnection = false;
//           _connectionChangeController(hasConnection!);
//         }
//       }
//     } on SocketException catch (_) {
//       hasConnection = false;
//       _connectionChangeController(hasConnection!);
//     }
//
//     return hasConnection;
//   }
//   // void _connectionChangeController(bool _hasConnection) {
//   //   if (_hasConnection) {
//   //     emit(ConnectivityOnlineState());
//   //   } else {
//   //     emit(ConnectivityOfflineState());
//   //   }
//   // }
}



// }