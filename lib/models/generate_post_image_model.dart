

class GeneratePostImage {
  List<String>? images;

  GeneratePostImage({this.images});

  GeneratePostImage.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}
