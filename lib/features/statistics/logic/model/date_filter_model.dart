enum DateFilterModel {
  today,
  yesterday,
  lastWeek,
  lastMonth,
  lastYear,
  allTime
}

extension DateFilterModelExtension on DateFilterModel {
  String get name {
    switch (this) {
      case DateFilterModel.allTime:
        return "All Time";
      case DateFilterModel.today:
        return "Today";
      case DateFilterModel.yesterday:
        return "Yesterday";
      case DateFilterModel.lastWeek:
        return "Last Week";
      case DateFilterModel.lastMonth:
        return "Last Month";
      case DateFilterModel.lastYear:
        return "Last Year";
    }
  }

  static DateFilterModel fromString(String value) {
    switch (value) {
      case "All Time":
        return DateFilterModel.allTime;
      case "Today":
        return DateFilterModel.today;
      case "Yesterday":
        return DateFilterModel.yesterday;
      case "Last Week":
        return DateFilterModel.lastWeek;
      case "Last Year":
        return DateFilterModel.lastYear;
      default:
        throw ArgumentError('Unknown value: $value');
    }
  }
}
