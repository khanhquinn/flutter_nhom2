class Product {
  final String name;
  final double price;
  final String image;
  final int quantitySold;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.quantitySold = 0,
  });
}

// Mô tả mẫu (Dùng để hiển thị trong ProductDetailPage)
const String defaultCardDesc =
    "Bộ bài tuyệt đẹp này là công cụ hoàn hảo để bắt đầu hành trình bói toán của bạn. Hình ảnh rõ ràng, dễ hiểu giúp bạn kết nối nhanh chóng và nhận được hướng dẫn chính xác.";
const String defaultStoneDesc =
    "Viên đá tự nhiên, đã được thanh tẩy năng lượng, hoàn hảo để thiền định, tăng cường trực giác và bảo vệ khỏi năng lượng tiêu cực. Kích thước nhỏ gọn, dễ mang theo.";
const String defaultSmudgeDesc =
    "Sản phẩm thanh tẩy tự nhiên, giúp loại bỏ năng lượng trì trệ và thu hút sự tích cực. Tuyệt vời cho việc thanh lọc không gian, đồ vật, hoặc trước/sau khi thực hành bói toán.";
const String defaultAccessoryDesc =
    "Phụ kiện chất lượng cao, thiết kế độc đáo, giúp nâng tầm không gian đọc bài của bạn hoặc là một món quà ý nghĩa cho những người yêu thích tâm linh.";
const String defaultBookDesc =
    "Cuốn sách hướng dẫn chi tiết, dễ tiếp cận, giúp bạn nắm vững kiến thức từ cơ bản đến nâng cao về bói toán, từ đó tự tin đưa ra những quyết định sáng suốt trong cuộc sống.";

List<Product> products = [
  Product(
    name: "Bài Oracle cho người mới",
    price: 150000,
    image: "assets/oracle.jpg",
    quantitySold: 1225,
    description:
        "Bộ Oracle hoàn hảo cho người mới bắt đầu, với thông điệp rõ ràng, không cần ghi nhớ nhiều. Giúp bạn kết nối với trực giác và nhận lời khuyên sâu sắc về tình cảm, công việc.",
  ),
  Product(
    name: "Bài Lenormand Cổ Điển",
    price: 350000,
    image: "assets/oldstyle_lenormand.jpg",
    quantitySold: 1205,
    description:
        "Bộ bài Lenormand mang phong cách cổ điển, hình ảnh truyền thống, giúp bạn nắm bắt các sự kiện thực tế và câu chuyện cuộc sống hàng ngày một cách chính xác và chi tiết.",
  ),
  Product(
    name: "Bài Tea Leaf Reading",
    price: 200000,
    image: "assets/tea_leaf.jpg",
    quantitySold: 1150,
    description:
        "Lấy cảm hứng từ nghệ thuật đọc bã trà truyền thống, bộ bài này mang đến những biểu tượng lãng mạn, huyền bí, giúp bạn tiên đoán vận mệnh thông qua hình ảnh mang tính thơ mộng.",
  ),
  Product(
    name: "Bài Kipper Đức",
    price: 520000,
    image: "assets/kipper.jpg",
    quantitySold: 200,
    description:
        "Bộ bài Kipper truyền thống của Đức, tập trung vào mối quan hệ giữa các nhân vật và sự kiện xã hội. Rất mạnh mẽ trong việc dự đoán về người và các mối quan hệ phức tạp.",
  ),
  Product(
    name: "Bài Waite Tarot Phong Cách Cổ",
    price: 450000,
    image: "assets/waite.jpg",
    quantitySold: 1875,
    description:
        "Phiên bản tái hiện phong cách cổ xưa của bộ Rider-Waite Smith kinh điển. Chất liệu giấy cao cấp, màu sắc trầm ấm, mang lại cảm giác hoài cổ và uyên bác khi sử dụng.",
  ),
  Product(
    name: "Bài New Vision Tarot",
    price: 500000,
    image: "assets/new_vision.jpg",
    quantitySold: 1150,
    description:
        "New Vision Tarot cung cấp góc nhìn 3D độc đáo cho các lá bài Waite kinh điển. Giúp bạn thấy được những gì đang diễn ra phía sau nhân vật, tăng chiều sâu cho việc giải nghĩa bài.",
  ),
  Product(
    name: "Đá Rainbow fluorite",
    price: 150000,
    image: "assets/rainbow.jpg",
    quantitySold: 90,
    description:
        "Rainbow Fluorite là viên đá của sự tập trung và trật tự. Giúp làm dịu tâm trí, tăng cường khả năng học tập, ghi nhớ và sắp xếp cuộc sống một cách logic, hiệu quả.",
  ),
  Product(
    name: "Đá Red agate",
    price: 55000,
    image: "assets/red.jpg",
    quantitySold: 180,
    description:
        "Red Agate mang lại sự bình tĩnh và sức mạnh nội tại. Hỗ trợ cân bằng cảm xúc, giảm căng thẳng và bảo vệ bạn khỏi các năng lượng tiêu cực xung quanh.",
  ),
  Product(
    name: "Đá Green aventurine",
    price: 35000,
    image: "assets/green.jpg",
    quantitySold: 550,
    description:
        "Green Aventurine được mệnh danh là 'viên đá cơ hội'. Thu hút may mắn, thịnh vượng và thành công. Tuyệt vời cho những ai đang bắt đầu các dự án mới hoặc tìm kiếm vận may.",
  ),
  Product(
    name: "Đá Citrine vàng mật",
    price: 30000,
    image: "assets/yellow.jpg",
    quantitySold: 1110,
    description:
        "Citrine (Thạch anh vàng) là viên đá của tiền tài và năng lượng mặt trời. Mang lại niềm vui, sự giàu có và giúp bạn duy trì tinh thần lạc quan, xua tan nỗi sợ hãi.",
  ),
  Product(
    name: "Đá Thạch anh trắng",
    price: 65000,
    image: "assets/white.jpg",
    quantitySold: 960,
    description:
        "Thạch anh trắng là bậc thầy chữa lành. Giúp khuếch đại năng lượng, làm sạch hào quang và tăng cường khả năng thiền định, giao tiếp tâm linh.",
  ),
  Product(
    name: "Đá Thạch anh hồng",
    price: 50000,
    image: "assets/pink.jpg",
    quantitySold: 165,
    description:
        "Thạch anh hồng là viên đá của tình yêu vô điều kiện. Thu hút tình yêu, hàn gắn vết thương lòng và mang lại sự bình yên, tự chấp nhận bản thân.",
  ),
  Product(
    name: "Xô Thơm thanh tẩy",
    price: 110000,
    image: "assets/xo_thom.jpg",
    quantitySold: 356,
    description:
        "Bó Xô Thơm Trắng (White Sage) được thu hoạch bền vững. Sử dụng để làm sạch không gian, loại bỏ các năng lượng cũ, trì trệ và chuẩn bị môi trường cho các nghi lễ tâm linh.",
  ),
  Product(
    name: "Trầm Palo thanh tẩy",
    price: 75000,
    image: "assets/palo.jpg",
    quantitySold: 1159,
    description:
        "Trầm Palo Santo (Gỗ Thánh) từ Peru. Hương thơm ngọt ngào, ấm áp, không chỉ thanh tẩy mà còn thu hút may mắn và nâng cao rung động. Đốt sau khi dùng Xô Thơm để đón nhận năng lượng tích cực.",
  ),
  Product(
    name: "Trầm nụ Huế ",
    price: 200000,
    image: "assets/tram_nu.jpg",
    quantitySold: 108,
    description:
        "Trầm nụ nguyên chất từ trầm hương thiên nhiên, được chế tác thủ công tại Huế. Hương thơm thanh khiết, giúp tĩnh tâm, thư giãn và tạo không gian trang nghiêm khi thờ cúng hoặc thiền định.",
  ),
  Product(
    name: "Đồng xu phán quyết Yes/No",
    price: 25000,
    image: "assets/xu.jpg",
    quantitySold: 1155,
    description:
        "Đồng xu kim loại khắc Yes/No (Có/Không). Công cụ vui vẻ và tiện lợi để đưa ra những quyết định nhanh chóng, không cần phức tạp hóa. Có thể dùng làm vật trang trí bàn làm việc.",
  ),
  Product(
    name: "Kệ gỗ nhiều tầng để bài Tarot",
    price: 680000,
    image: "assets/ke.jpg",
    quantitySold: 45,
    description:
        "Kệ gỗ thủ công, đa tầng, thiết kế đặc biệt để trưng bày các bộ bài Tarot, đá quý và các vật phẩm tâm linh khác. Giúp không gian trở nên ngăn nắp và trang trọng hơn.",
  ),
  Product(
    name: "Vị Thần của những quyết định",
    price: 70000,
    image: "assets/sach.jpg",
    quantitySold: 105,
    description:
        "Cuốn sách bán chạy, cung cấp các phương pháp và nguyên tắc để đưa ra các quyết định khó khăn trong cuộc sống, dựa trên trực giác và các kỹ thuật tư duy logic. Phù hợp cho mọi đối tượng.",
  ),
  Product(
    name: "Khăn trải Bàn Bói Tarot ngôi sao",
    price: 75000,
    image: "assets/khan1.jpg",
    quantitySold: 130,
    description:
        "Khăn trải bài bằng chất liệu nhung mềm, in hình ngôi sao huyền bí. Tạo ra một không gian thiêng liêng, bảo vệ các lá bài và giúp tăng cường sự tập trung khi đọc bài.",
  ),
  Product(
    name: "Khăn trải bàn 12 Cung Hoàng Đạo",
    price: 80000,
    image: "assets/khan2.jpg",
    quantitySold: 65,
    description:
        "Khăn trải bài sang trọng, in chi tiết 12 cung Hoàng Đạo. Hoàn hảo để trải bài chiêm tinh hoặc làm quà tặng cho những người đam mê tử vi và chiêm tinh học.",
  ),
];
