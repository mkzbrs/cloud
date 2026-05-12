enum ItemType { folder, image, document, video, other }

class FileItem {
  final String name;
  final String size;
  final String date;
  final ItemType type;

  FileItem({
    required this.name,
    required this.size,
    required this.date,
    required this.type,
  });
}