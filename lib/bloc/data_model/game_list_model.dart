class GameListModel {
  final GameType type;
  final String title;
  final String imgPath;

  GameListModel(
      {required this.type, required this.title, required this.imgPath});
}

enum GameType { Snake, FlappyBird }
