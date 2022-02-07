class Content{
  String title;
  String content;

  Content({this.title, this.content});

  factory Content.fromJson(Map<String, dynamic> json){
    return new Content(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }

}