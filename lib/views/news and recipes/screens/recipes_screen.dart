import 'package:flutter/material.dart';
import 'package:life_sync/models/news_model.dart';
import 'package:life_sync/views/news%20and%20recipes/widgets/card_loading_widget.dart';
import 'package:life_sync/views/news%20and%20recipes/widgets/news_card_widget.dart';

import '../../../controller/news_controller.dart';
import '../../diary/widgets/foodList/my_search_bar_view.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final NewsController _newsController = NewsController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySearchBar(),
        Expanded(
          child: FutureBuilder<List<News>>(
            future: _newsController.fetchNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const LoadingCard();
                  },
                  padding: const EdgeInsets.only(bottom: 85.0),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Could not retrieve data: ${snapshot.error}'),
                );
              } else {
                final news = snapshot.data;
                return ListView.builder(
                  itemCount: news?.length,
                  itemBuilder: (context, index) {
                    return NewsCard(news: news, index: index);
                  },
                  padding: const EdgeInsets.only(bottom: 85.0),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
