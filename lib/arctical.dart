import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const String _apiKey = '1747702e5beb4c8a9e4b5e1efdb5554b';
// Lấy tin tức hàng đầu của Mỹ
const String _apiUrl =
    'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

// lib/models/article.dart

class Article {
  final String? title;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? url;
  final String? sourceName;

  Article({
    this.title,
    this.description,
    this.urlToImage,
    this.content,
    this.url,
    this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      url: json['url'],
      sourceName: json['source'] != null ? json['source']['name'] : 'Unknown',
    );
  }
}

// --- 2. MÀN HÌNH DANH SÁCH (NewsListScreen) ---
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  // Hàm gọi API lấy dữ liệu
  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['articles'] != null) {
          final List<dynamic> articlesJson = data['articles'];
          if (mounted) {
            setState(() {
              articles = articlesJson
                  .map((json) => Article.fromJson(json))
                  .toList();
              isLoading = false;
            });
          }
        }
      } else {
        debugPrint('Lỗi server: ${response.statusCode}');
        if (mounted) setState(() => isLoading = false);
      }
    } catch (e) {
      debugPrint('Lỗi kết nối: $e');
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin Tức Mới Nhất'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : articles.isEmpty
          ? const Center(child: Text("Không tải được tin tức nào."))
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  elevation: 3,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailScreen(article: article),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ảnh Thumbnail
                        if (article.urlToImage != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                            child: Image.network(
                              article.urlToImage!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) =>
                                  const SizedBox(height: 0),
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // --- PHẦN ĐÃ SỬA LỖI TẠI ĐÂY ---
                              Text(
                                article.title ?? 'Không tiêu đề',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // -------------------------------
                              const SizedBox(height: 6),
                              Text(
                                article.description ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// --- 3. MÀN HÌNH CHI TIẾT (NewsDetailScreen) ---
class NewsDetailScreen extends StatelessWidget {
  final Article article;

  const NewsDetailScreen({super.key, required this.article});

  Future<void> _launchURL() async {
    if (article.url != null) {
      final Uri url = Uri.parse(article.url!);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint('Không thể mở link: $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi Tiết Bài Viết')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              Image.network(
                article.urlToImage!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => const SizedBox(
                  height: 200,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Nguồn: ${article.sourceName}',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Link gốc:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    article.url ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    article.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article.content ?? 'Không có nội dung chi tiết.',
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.public),
                      label: const Text('Đọc bài viết trên Web'),
                      onPressed: _launchURL,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
