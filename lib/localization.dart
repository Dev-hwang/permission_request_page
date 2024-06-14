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
    'locationAlways': '위치',
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
    'accessMediaLocation': '미디어',
    'activityRecognition': '활동인식',
    'bluetooth': '블루투스',
    'bluetoothScan': '블루투스 검색',
    'bluetoothAdvertise': '블루투스 광고',
    'bluetoothConnect': '블루투스 연결',
    'systemAlertWindow': '화면 오버레이',
  },
  'permissionDesc': {
    'calendar': '기기의 캘린더에 접근하기 위한 권한입니다.',
    'camera': '기기의 카메라에 접근하기 위한 권한입니다.',
    'contacts': '기기의 연락처에 접근하기 위한 권한입니다.',
    'location': '기기의 위치에 접근하기 위한 권한입니다.',
    'locationAlways': '앱이 백그라운드에서 실행 중일 때 기기의 위치에 접근하기 위한 권한입니다.',
    'mediaLibrary': '기기의 미디어 라이브러리에 접근하기 위한 권한입니다.',
    'microphone': '기기의 마이크에 접근하기 위한 권한입니다.',
    'phone': '기기의 휴대폰 상태에 접근하기 위한 권한입니다.',
    'photos': '기기의 사진에 접근하기 위한 권한입니다.',
    'reminders': '기기의 알림에 접근하기 위한 권한입니다.',
    'sensors': '기기의 센서에 접근하기 위한 권한입니다.',
    'sms': 'SMS 메시지를 보내고 읽기 위한 권한입니다.',
    'speech': '음성인식 접근을 위한 권한입니다.',
    'storage': '외부 저장소에 접근하기 위한 권한입니다.',
    'notification': '푸시 알림에 대한 권한입니다.',
    'accessMediaLocation': '기기의 미디어 라이브러리에 접근하기 위한 권한입니다.',
    'activityRecognition': '활동 인식에 접근하기 위한 권한입니다.',
    'bluetooth': '기기의 블루투스 어댑터 상태에 접근하기 위한 권한입니다.',
    'bluetoothScan': '블루투스 장치 검색을 위한 권한입니다.',
    'bluetoothAdvertise': '블루투스 기기 광고에 대한 권한입니다.',
    'bluetoothConnect': '블루투스 기기 연결을 위한 권한입니다.',
    'systemAlertWindow': '화면 오버레이를 위한 권한입니다.',
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
    'locationAlways': 'Location',
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
    'systemAlertWindow': 'Window Overlay',
  },
  'permissionDesc': {
    'calendar': 'Permission for accessing the device\'s calendar.',
    'camera': 'Permission for accessing the device\'s camera.',
    'contacts': 'Permission for accessing the device\'s contacts.',
    'location': 'Permission for accessing the device\'s location.',
    'locationAlways': 'Permission for accessing the device\'s location when the app is running in the background.',
    'mediaLibrary': 'Permission for accessing the device\'s media library.',
    'microphone': 'Permission for accessing the device\'s microphone.',
    'phone': 'Permission for accessing the device\'s phone state.',
    'photos': 'Permission for accessing the device\'s photos.',
    'reminders': 'Permission for accessing the device\'s reminders.',
    'sensors': 'Permission for accessing the device\'s sensors.',
    'sms': 'Permission for sending and reading SMS messages.',
    'speech': 'Permission for accessing speech recognition.',
    'storage': 'Permission for accessing external storage.',
    'notification': 'Permission for pushing notifications.',
    'accessMediaLocation': 'Permission for accessing the device\'s media library.',
    'activityRecognition': 'Permission for accessing the activity recognition.',
    'bluetooth': 'Permission for accessing the device\'s bluetooth adapter state.',
    'bluetoothScan': 'Permission for scanning for Bluetooth devices.',
    'bluetoothAdvertise': 'Permission for advertising Bluetooth devices.',
    'bluetoothConnect': 'Permission for connecting to Bluetooth devices.',
    'systemAlertWindow': 'Permission for creating system alert window.',
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
