import 'dart:io';

class Localization {
  static String get localeName => Platform.localeName;

  static Map<String, dynamic> get dictionary {
    if (localeName == 'ko_KR') {
      return _korean;
    } else {
      return _english;
    }
  }

  static String necessary(bool isNecessary) {
    return isNecessary
        ? dictionary['necessaryTrue']
        : dictionary['necessaryFalse'];
  }

  static String permissionName(String key) {
    return dictionary['permissionName']?[key] ?? 'unknown';
  }

  static String permissionDesc(String key) {
    return dictionary['permissionDesc']?[key] ?? 'unknown';
  }
}

const Map<String, dynamic> _korean = {
  'necessaryTrue': '(필수)',
  'necessaryFalse': '',
  'permissionName': {
    'calendar': '캘린더',
    'camera': '카메라',
    'contacts': '연락처',
    'location': '위치',
    'locationAlways': '위치-백그라운드',
    'mediaLibrary': '미디어',
    'microphone': '마이크',
    'phone': '전화',
    'photos': '갤러리',
    'reminders': '리마인더',
    'sensors': '센서',
    'sms': '메시지',
    'speech': '음성',
    'storage': '저장소',
    'notification': '알림',
    'accessMediaLocation': '미디어 위치',
    'activityRecognition': '활동 인식',
    'bluetooth': '블루투스',
    'bluetoothScan': '블루투스 검색',
    'bluetoothAdvertise': '블루투스 광고',
    'bluetoothConnect': '블루투스 연결',
    'systemAlertWindow': '화면 그리기',
  },
  'permissionDesc': {
    'calendar': '캘린더 데이터에 접근하기 위해 필요합니다.',
    'camera': '카메라를 사용하기 위해 필요합니다.',
    'contacts': '연락처 데이터에 접근하기 위해 필요합니다.',
    'location': '위치 서비스를 제공하기 위해 필요합니다.',
    'locationAlways': '백그라운드 위치 서비스를 제공하기 위해 필요합니다.',
    'mediaLibrary': '미디어 라이브러리에 접근하기 위해 필요합니다.',
    'microphone': '마이크를 사용하기 위해 필요합니다.',
    'phone': '디바이스 상태를 읽거나 통화 기능을 제공하기 위해 필요합니다.',
    'photos': '갤러리 데이터에 접근하기 위해 필요합니다.',
    'reminders': '리마인더에 접근하기 위해 필요합니다.',
    'sensors': '센서에 접근하기 위해 필요합니다.',
    'sms': '메시지 데이터에 접근하기 위해 필요합니다.',
    'speech': '음성 서비스를 제공하기 위해 필요합니다.',
    'storage': '스마트폰 내부 저장소에 접근하기 위해 필요합니다.',
    'notification': '노티피케이션을 제공하기 위해 필요합니다.',
    'accessMediaLocation': '미디어 파일에 접근하기 위해 필요합니다.',
    'activityRecognition': '사용자의 활동을 인식하기 위해 필요합니다.',
    'bluetooth': '블루투스 장치에 접근하기 위해 필요합니다.',
    'bluetoothScan': '블루투스 장치를 검색하기 위해 필요합니다.',
    'bluetoothAdvertise': '블루투스 장치를 광고하기 위해 필요합니다.',
    'bluetoothConnect': '블루투스 장치와 연결하기 위해 필요합니다.',
    'systemAlertWindow': '다른 앱 위에 앱 컨텐츠를 그리기 위해 필요합니다.',
  },
  'permissionViewHeaderText': '어플리케이션 사용을 위해\n다음 권한의 허용이 필요합니다.',
  'permissionRequestButtonText': '확인',
  'msgWhenPermissionDenied': '어플리케이션을 사용하려면 다음 권한을 허용해야 합니다: ',
  'appInitializationErrMsg': '앱 초기화에 실패하여 앱을 시작할 수 없습니다.',
  'dialogRetryButtonText': '재시도',
  'dialogExitButtonText': '종료',
  'dialogPositiveButtonText': '확인',
  'dialogNegativeButtonText': '취소',
};

const Map<String, dynamic> _english = {
  'necessaryTrue': '(Required)',
  'necessaryFalse': '',
  'permissionName': {
    'calendar': 'Calendar',
    'camera': 'Camera',
    'contacts': 'Contacts',
    'location': 'Location',
    'locationAlways': 'Location-Background',
    'mediaLibrary': 'Media Library',
    'microphone': 'Microphone',
    'phone': 'Phone',
    'photos': 'Photos',
    'reminders': 'Reminders',
    'sensors': 'Sensors',
    'sms': 'SMS',
    'speech': 'Speech',
    'storage': 'Storage',
    'notification': 'Notification',
    'accessMediaLocation': 'Media Location',
    'activityRecognition': 'Activity Recognition',
    'bluetooth': 'Bluetooth',
    'bluetoothScan': 'Bluetooth Scan',
    'bluetoothAdvertise': 'Bluetooth Advertise',
    'bluetoothConnect': 'Bluetooth Connect',
    'systemAlertWindow': 'Draw Window',
  },
  'permissionDesc': {
    'calendar': 'Required to access calendar data.',
    'camera': 'Required to use the camera.',
    'contacts': 'Required to access contact data.',
    'location': 'Required to provide location services.',
    'locationAlways': 'Required to provide background location services.',
    'mediaLibrary': 'Required to access the media library.',
    'microphone': 'Required to use the microphone.',
    'phone': 'Required to read device state or provide call functions.',
    'photos': 'Required to access gallery data.',
    'reminders': 'Required to access reminders.',
    'sensors': 'Required to access the sensor.',
    'sms': 'Required to access message data.',
    'speech': 'Required to provide voice service.',
    'storage': 'Required to access the internal storage of the smartphone.',
    'notification': 'Required to provide notifications.',
    'accessMediaLocation': 'Required to access media files.',
    'activityRecognition': 'Required to recognize user activity.',
    'bluetooth': 'Required to access Bluetooth devices.',
    'bluetoothScan': 'Required to discover Bluetooth devices.',
    'bluetoothAdvertise': 'Required to advertise Bluetooth devices.',
    'bluetoothConnect': 'Required to connect Bluetooth devices.',
    'systemAlertWindow': 'Required to draw app content on top of other apps.',
  },
  'permissionViewHeaderText': 'The following permissions are required to use the application.',
  'permissionRequestButtonText': 'NEXT',
  'msgWhenPermissionDenied': 'To use the application, you must grant the following permissions: ',
  'appInitializationErrMsg': 'The app cannot be started because the app initialization failed.',
  'dialogRetryButtonText': 'Retry',
  'dialogExitButtonText': 'Exit',
  'dialogPositiveButtonText': 'Confirm',
  'dialogNegativeButtonText': 'Cancel',
};
