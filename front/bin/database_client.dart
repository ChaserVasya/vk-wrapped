import 'dart:io';
import '../lib/database_client.dart';

void main() async {
  print('🔗 Database Client Test');
  print('=======================');
  print('');
  print('📋 This script requires:');
  print('1. Node.js and npm installed');
  print('2. ../yandex-cloud/functions directory with package.json');
  print('3. Valid YDB_TOKEN in ../yandex-cloud/functions/.local.env');
  print('');

  try {
    final data = await DatabaseClient.getDatabaseData();

    final currentSessions = data['currentSessions'] as List;
    final completedSessions = data['completedSessions'] as List;

    print('✅ Successfully retrieved data from database');
    print('📊 Found ${currentSessions.length} current sessions');
    print('📊 Found ${completedSessions.length} completed sessions');

    _printSessions(currentSessions, 'Current Sessions');
    _printSessions(completedSessions, 'Completed Sessions');

    print('\n✅ Database client completed successfully');
  } catch (error) {
    print('❌ Error: $error');
    print('');
    print('💡 Troubleshooting:');
    print('- Check if ../yandex-cloud/functions exists');
    print('- Run: cd ../yandex-cloud/functions && npm install');
    print('- Ensure YDB_TOKEN is set in .local.env');
    exit(1);
  }
}

void _printSessions(List<dynamic> sessions, String title) {
  print('\n📋 $title:');

  if (sessions.isEmpty) {
    print('  No sessions found');
    return;
  }

  for (int i = 0; i < sessions.length; i++) {
    final session = sessions[i];
    final fullId = session['full_id'] ?? 'Unknown';
    final firstObserved = session['first_observed'];
    final lastSeen = session['last_seen'];

    // Вычисляем длительность
    final firstDate = DateTime.parse(firstObserved);
    final lastDate = DateTime.parse(lastSeen);
    final duration = lastDate.difference(firstDate).inMinutes;

    print('''
  ${i + 1}. $fullId
     Started: $firstObserved
     ${title.contains('Current') ? 'Last seen' : 'Ended'}: $lastSeen
     Duration: $duration minutes''');
  }
}
