class ImageDimension {
  final double width;
  final double height;
  final String aspectRatio;
  final String priceEquivalentTo;

  ImageDimension ({
    required this.width,
    required this.height,
    required this.aspectRatio,
    required this.priceEquivalentTo,
  });
}


  List<ImageDimension> imageDimensionList = [
    ImageDimension(width: 1024, height: 1024, aspectRatio: "1:1", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 768, height: 768, aspectRatio: "1:1", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 512, height: 512, aspectRatio: "1:1", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 768, height: 1152, aspectRatio: "2:3", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 384, height: 576, aspectRatio: "2:3", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 1152, height: 768, aspectRatio: "3:2", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 576, height: 384, aspectRatio: "3:2", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 768, height: 1280, aspectRatio: "3:5", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 384, height: 640, aspectRatio: "3:5", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 1280, height: 768, aspectRatio: "5:3", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 640, height: 384, aspectRatio: "5:3", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 896, height: 1152, aspectRatio: "7:9", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 448, height: 576, aspectRatio: "7:9", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 1152, height: 896, aspectRatio: "9:7", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 576, height: 448, aspectRatio: "9:7", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 768, height: 1408, aspectRatio: "6:11", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 384, height: 704, aspectRatio: "6:11", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 1408, height: 768, aspectRatio: "11:6", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 704, height: 384, aspectRatio: "11:6", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 640, height: 1408, aspectRatio: "5:11", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 320, height: 704, aspectRatio: "5:11", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 1408, height: 640, aspectRatio: "11:5", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 704, height: 320, aspectRatio: "11:5", priceEquivalentTo: "512 x 512"),
    ImageDimension(width: 1152, height: 640, aspectRatio: "9:5", priceEquivalentTo: "1024 x 1024"),
    ImageDimension(width: 1173, height: 640, aspectRatio: "16:9", priceEquivalentTo: "1024 x 1024"),
  ];

  
