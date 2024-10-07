enum WebsiteIdentifier {
  eeclass,
  courseSelect,
}

extension WebsiteIdentifierX on WebsiteIdentifier {
  String get name {
    switch (this) {
      case WebsiteIdentifier.eeclass:
        return 'EEClass';
      case WebsiteIdentifier.courseSelect:
        return 'CourseSelect';
    }
  }
}