extension StringExtensions on String {
  String get toCapitalized {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get toTitleCase {
    if (isEmpty) return '';
    return split(' ').map((str) => str.toCapitalized).join(' ');
  }
}
