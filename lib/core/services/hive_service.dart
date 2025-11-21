import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer' as dev;
import '../../features/auth/data/models/login_profile_model.dart';
import '../../features/auth/data/models/login_response_model.dart';

class HiveService {
  // Singleton pattern
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  static const String _profileBox = 'profileBox';

  /// ✅ Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters (if not already registered)
    if (!Hive.isAdapterRegistered(LoginProfileModelAdapter().typeId)) {
      Hive.registerAdapter(LoginProfileModelAdapter());
      dev.log('📦 LoginProfileModelAdapter registered', name: 'HiveService');
    }

    // Open box if not already open
    if (!Hive.isBoxOpen(_profileBox)) {
      await Hive.openBox<LoginProfileModel>(_profileBox);
      dev.log('📦 Box $_profileBox opened', name: 'HiveService');
    }

    dev.log('✅ HiveService initialized successfully', name: 'HiveService');
  }

  /// 💾 Save user profile
  Future<void> saveProfile(LoginProfileModel profile) async {
    final box = Hive.box<LoginProfileModel>(_profileBox);
    await box.put('userProfile', profile);
    dev.log(
      '💾 Profile saved: ${profile.firstName} ${profile.lastName}',
      name: 'HiveService',
    );
  }

  /// 📤 Get stored profile
  LoginProfileModel? getProfile() {
    final box = Hive.box<LoginProfileModel>(_profileBox);
    final profile = box.get('userProfile');
    dev.log(
      '📤 Retrieved profile: ${profile?.firstName ?? 'null'}',
      name: 'HiveService',
    );
    return profile;
  }

  /// 🗑️ Delete stored profile
  Future<void> clearProfile() async {
    final box = Hive.box<LoginProfileModel>(_profileBox);
    await box.delete('userProfile');
    dev.log('🗑️ Profile cleared', name: 'HiveService');
  }

  /// 🧹 Clear all Hive data (optional)
  Future<void> clearAll() async {
    if (Hive.isBoxOpen(_profileBox)) {
      await Hive.box<LoginProfileModel>(_profileBox).clear();
    }
    await Hive.deleteBoxFromDisk(_profileBox);
    dev.log('🧹 All Hive data cleared', name: 'HiveService');
  }
}
