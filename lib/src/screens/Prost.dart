class Post {
  final String title;
  final String body;
  final String imageUrl;
  final String createdBy; // Agregar campo para almacenar el nombre del creador

  Post({required this.title, required this.body, required this.imageUrl, required this.createdBy});
}
