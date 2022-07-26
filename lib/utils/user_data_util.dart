import 'dart:async';
import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nano_ffi/flutter_nano_ffi.dart';
import 'package:mysarafu/l10n/l10n.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:quiver/strings.dart';
import 'package:validators/validators.dart';
import 'package:web3dart/credentials.dart';

enum DataType { raw, url, address, seed }

class QRScanErrs {
  static const String permissionDenied = 'qr_denied';
  static const String unknownError = 'qr_unknown';
  static const String cancelError = 'qr_cancel';
  static const List<String> errorList = [
    permissionDenied,
    unknownError,
    cancelError
  ];
}

class UserDataUtil {
  static const MethodChannel _channel = MethodChannel('fappchannel');
  static StreamSubscription<dynamic>? setStream;

  static String? _parseData(String data, DataType type) {
    final dataTrimmed = data.trim();
    if (type == DataType.raw) {
      return dataTrimmed;
    } else if (type == DataType.url) {
      if (isIP(dataTrimmed)) {
        return dataTrimmed;
      } else if (isURL(dataTrimmed)) {
        return dataTrimmed;
      }
    } else if (type == DataType.address) {
      final address = EthereumAddress.fromHex(dataTrimmed);
      return address.hexEip55;
    } else if (type == DataType.seed) {
      // Check if valid seed
      if (NanoSeeds.isValidSeed(dataTrimmed)) {
        return dataTrimmed;
      }
    }
    return null;
  }

  static Future<String?> getClipboardText(DataType type) async {
    final data = await Clipboard.getData('text/plain');
    if (data == null || data.text == null) {
      return null;
    }
    return _parseData(data.text!, type);
  }

  static Future<String?> getQRData(DataType type, BuildContext context) async {
    final l10n = context.l10n;

    try {
      final result = await BarcodeScanner.scan();
      final data = result.rawContent;
      if (isEmpty(data)) {
        return null;
      }
      return _parseData(data, type);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(l10n.qrInvalidPermissions),
          ),
        );
        return QRScanErrs.permissionDenied;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(l10n.qrUnknownError),
          ),
        );

        return QRScanErrs.unknownError;
      }
    } on FormatException {
      return QRScanErrs.cancelError;
    } catch (e) {
      log.e('Unknown QR Scan Error ${e.toString()}', e);
      return QRScanErrs.unknownError;
    }
  }

  static Future<void> setSecureClipboardItem(String value) async {
    if (Platform.isIOS) {
      final params = <String, dynamic>{
        'value': value,
      };
      await _channel.invokeMethod<void>('setSecureClipboardItem', params);
    } else {
      // Set item in clipboard
      await Clipboard.setData(ClipboardData(text: value));
      // Auto clear it after 2 minutes
      if (setStream != null) {
        await setStream?.cancel();
      }
      final delayed = Future<dynamic>.delayed(const Duration(minutes: 2));
      await delayed.then((dynamic _) {
        return true;
      });
      setStream = delayed.asStream().listen((dynamic _) {
        Clipboard.getData('text/plain').then((data) {
          if (data != null &&
              data.text != null &&
              NanoSeeds.isValidSeed(data.text!)) {
            Clipboard.setData(const ClipboardData(text: ''));
          }
        });
      });
    }
  }
}
