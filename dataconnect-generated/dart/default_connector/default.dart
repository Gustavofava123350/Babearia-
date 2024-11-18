library default_connector;

import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

// Definindo a classe ConnectorConfig
class ConnectorConfig {
  final String region;
  final String connectorId;
  final String projectId;

  ConnectorConfig(this.region, this.connectorId, this.projectId);
}

class DefaultConnector {
  static final ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'default',
    'ellys',
  );

  DefaultConnector({required this.dataConnect});

  static DefaultConnector? _instance;

  static DefaultConnector get instance {
    return _instance ??= DefaultConnector(
      dataConnect: FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
        sdkType: CallerSDKType.generated,
      ),
    );
  }

  final FirebaseDataConnect dataConnect;
}
