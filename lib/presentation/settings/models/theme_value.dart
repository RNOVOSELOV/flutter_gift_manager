enum ThemeValues {
  light(valueId: 1, name: 'Светлая тема'),
  dark(valueId: 2, name: 'Темная тема'),
  system(valueId: 3, name: 'Системная тема');

  final String name;
  final String description;
  final int valueId;

  const ThemeValues(
      {required this.valueId, required this.name, this.description = ''});
}
