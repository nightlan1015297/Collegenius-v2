enum WebsiteIdentifier {
  eeclass,
  courseSelect,
}

extension WebsiteIdentifierX on WebsiteIdentifier {
  String get name {
    switch (this) {
      case WebsiteIdentifier.eeclass:
        return 'EE Class';
      case WebsiteIdentifier.courseSelect:
        return 'Course Selection System';
    }
  }
}