class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Cherchez',
      image: 'assets/bus.json',
      discription: "Trouvez des bus de voyage au Gabon"
  ),
  UnbordingContent(
      title: 'Comparez',
      image: 'assets/bus.json',
      discription: "Choisissez le trajet le plus rapide et économique parmi les offres de plusieurs partenaires"
  ),
  UnbordingContent(
      title: 'Réservez',
      image: 'assets/bus.json',
      discription: "Réservez vos billets peu importe oú vous soyez"
  ),
];