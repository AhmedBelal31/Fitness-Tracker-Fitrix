// lib/core/services/signalr_service.dart
import 'dart:developer' as dev;
import 'package:signalr_netcore/signalr_client.dart';
import '../networking/token_manager.dart';
import 'package:signalr_netcore/abort_controller.dart';
import 'package:signalr_netcore/binary_message_format.dart';
import 'package:signalr_netcore/default_reconnect_policy.dart';
import 'package:signalr_netcore/errors.dart';
import 'package:signalr_netcore/handshake_protocol.dart';
import 'package:signalr_netcore/http_connection.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/iconnection.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/iretry_policy.dart';
import 'package:signalr_netcore/itransport.dart';

class SignalRService {
  static SignalRService? _instance;
  HubConnection? _hubConnection;
  bool _connectionFailed = false;

  SignalRService._();

  static SignalRService get instance {
    _instance ??= SignalRService._();
    return _instance!;
  }

  bool get isConnected => _hubConnection?.state == HubConnectionState.Connected;

  Future<void> connect() async {
    if (_connectionFailed) {
      dev.log(
        '⚠️ SignalR connection previously failed, skipping',
        name: 'SignalRService',
      );
      return;
    }

    if (_hubConnection != null && isConnected) {
      dev.log('✅ SignalR already connected', name: 'SignalRService');
      return;
    }

    try {
      final token = await TokenManager.instance.getAccessToken();

      if (token == null) {
        dev.log('❌ No access token available', name: 'SignalRService');
        return;
      }

      final httpConnectionOptions = HttpConnectionOptions(
        accessTokenFactory: () async => token,
        logMessageContent: false,
        skipNegotiation: false,
        transport: HttpTransportType.WebSockets,
      );

      dev.log('🔄 Connecting to SignalR hub...', name: 'SignalRService');

      _hubConnection = HubConnectionBuilder()
          .withUrl(
            'https://gymassistantapi.runasp.net/chatHub',
            options: httpConnectionOptions,
          )
          .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 30000])
          .build();

      _hubConnection!.onclose(({error}) {
        dev.log('🔴 SignalR connection closed: $error', name: 'SignalRService');
      });

      _hubConnection!.onreconnecting(({error}) {
        dev.log('🟡 SignalR reconnecting: $error', name: 'SignalRService');
      });

      _hubConnection!.onreconnected(({connectionId}) {
        dev.log(
          '🟢 SignalR reconnected: $connectionId',
          name: 'SignalRService',
        );
      });

      await _hubConnection!.start();
      dev.log('✅ SignalR connected successfully', name: 'SignalRService');
    } catch (e) {
      _connectionFailed = true;
      dev.log('❌ SignalR connection error: $e', name: 'SignalRService');
    }
  }

  Future<void> disconnect() async {
    if (_hubConnection != null) {
      try {
        await _hubConnection!.stop();
        _hubConnection = null;
        dev.log('🔴 SignalR disconnected', name: 'SignalRService');
      } catch (e) {
        dev.log('❌ Error disconnecting: $e', name: 'SignalRService');
      }
    }
  }

  void onReceiveMessage(Function(Map<String, dynamic>) callback) {
    if (!isConnected) return;

    _hubConnection?.on('ReceiveMessage', (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        try {
          final messageData = arguments[0] as Map<String, dynamic>;
          dev.log('📨 Received message via SignalR', name: 'SignalRService');
          callback(messageData);
        } catch (e) {
          dev.log('❌ Error parsing message: $e', name: 'SignalRService');
        }
      }
    });
  }

  void onMessageRead(Function(String messageId) callback) {
    if (!isConnected) return;

    _hubConnection?.on('MessageRead', (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        try {
          final messageId = arguments[0] as String;
          dev.log('✅ Message read: $messageId', name: 'SignalRService');
          callback(messageId);
        } catch (e) {
          dev.log('❌ Error parsing read message: $e', name: 'SignalRService');
        }
      }
    });
  }

  Future<void> joinConversation(String conversationId) async {
    if (!isConnected) {
      dev.log(
        '⚠️ SignalR not connected, skipping join',
        name: 'SignalRService',
      );
      return;
    }

    try {
      // Try different possible method names
      final methodNames = [
        'JoinConversation',
        'JoinRoom',
        'SubscribeToConversation',
      ];

      for (final methodName in methodNames) {
        try {
          await _hubConnection?.invoke(
            methodName,
            args: <Object>[conversationId],
          );
          dev.log(
            '✅ Joined conversation using $methodName: $conversationId',
            name: 'SignalRService',
          );
          return; // Success!
        } catch (e) {
          dev.log(
            '⚠️ Method $methodName not available',
            name: 'SignalRService',
          );
        }
      }

      // If all failed, log but don't throw error
      dev.log(
        '⚠️ No join method available, messages will still work via ReceiveMessage',
        name: 'SignalRService',
      );
    } catch (e) {
      dev.log('❌ Failed to join conversation: $e', name: 'SignalRService');
    }
  }

  Future<void> leaveConversation(String conversationId) async {
    if (!isConnected) return;

    try {
      // Try different possible method names
      final methodNames = [
        'LeaveConversation',
        'LeaveRoom',
        'UnsubscribeFromConversation',
      ];

      for (final methodName in methodNames) {
        try {
          await _hubConnection?.invoke(
            methodName,
            args: <Object>[conversationId],
          );
          dev.log(
            '👋 Left conversation using $methodName: $conversationId',
            name: 'SignalRService',
          );
          return;
        } catch (e) {
          // Silently continue to next method
        }
      }
    } catch (e) {
      dev.log('❌ Failed to leave conversation: $e', name: 'SignalRService');
    }
  }
}
