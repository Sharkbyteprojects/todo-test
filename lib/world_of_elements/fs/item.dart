class Items {
  final String text;
  bool done;
  Items(this.text, this.done);

  Map<String, dynamic> toJson() => {'text': text, 'done': done};
  factory Items.fromJson(Map<String, dynamic> json) =>
      Items(json['text'], json['done']);
}
