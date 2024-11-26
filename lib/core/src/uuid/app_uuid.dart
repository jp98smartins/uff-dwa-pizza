import 'package:uuid/uuid.dart' as uuid;

enum UuidVersion { v1, v4, v7 }

abstract interface class AppUuid {
  String generate({UuidVersion? version});
}

final class AppUuidImpl implements AppUuid {
  @override
  String generate({UuidVersion? version}) {
    return switch (version) {
      UuidVersion.v1 => const uuid.Uuid().v1(),
      UuidVersion.v7 => const uuid.Uuid().v7(),
      _ => const uuid.Uuid().v4(),
    };
  }
}
