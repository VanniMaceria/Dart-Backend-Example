class Guitar {
  final String nome;
  final String urlImmagine;
  final String descrizione;

  Guitar({
    required this.nome,
    required this.urlImmagine,
    required this.descrizione,
  });

  // Metodo per convertire un'istanza di Guitar in un oggetto JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'urlImmagine': urlImmagine,
      'descrizione': descrizione,
    };
  }

  // Metodo factory per creare un'istanza di Guitar da un oggetto JSON
  factory Guitar.fromJson(Map<String, dynamic> json) {
    return Guitar(
      nome: json['nome'] as String,
      urlImmagine: json['urlImmagine'] as String,
      descrizione: json['descrizione'] as String,
    );
  }
}
