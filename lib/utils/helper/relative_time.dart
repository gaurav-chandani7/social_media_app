String getRelativeTime(String time) {
  var date = DateTime.tryParse(time);
  if (date == null) {
    return "";
  }
  var today = DateTime.now();
  var diff = today.difference(date);
  if (diff.inDays >= 365) {
    if (diff.inDays <= 547) {
      return "${diff.inDays} year ago";
    }
    return "${(diff.inDays / 365).round()} years ago";
  }
  if (diff.inDays >= 30) {
    if (diff.inDays <= 44) {
      return "${diff.inDays} month ago";
    }
    return "${(diff.inDays / 30).round()} months ago";
  }
  if (diff.inDays >= 1) {
    if (diff.inDays == 1) {
      return "${diff.inDays} day ago";
    }
    return "${diff.inDays} days ago";
  }
  if (diff.inHours >= 1) {
    if (diff.inHours == 1) {
      return "${diff.inHours} hour ago";
    }
    return "${diff.inHours} hours ago";
  }
  if (diff.inMinutes >= 1) {
    if (diff.inMinutes == 1) {
      return "${diff.inMinutes} min ago";
    }
    return "${diff.inMinutes} mins ago";
  }
  return "just now";
}
