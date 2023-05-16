import 'package:flutter/material.dart';
import 'package:retailhub/constants/app_colors.dart';
import 'package:stacked/stacked.dart';
import '../../../model/article_model.dart';
import '../../widgets/newsitem_widget.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import 'search_viewmodel.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, SearchViewModel? viewModel, Widget? child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              backgroundColor: backgroundColor,

              appBar: AppBar(
                bottom: TabBar(
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(text: "Startups"),
                    Tab(text: "Articles")
                  ],
                ),
                backgroundColor: backgroundColor,
                title: TextField(
                  controller: viewModel?.searchController,
                  style: const TextStyle(color: white),
                  textInputAction: TextInputAction.search,
                  onChanged: (ss) {
                    viewModel?.searchArticles();
                  },
                  onEditingComplete: (() => viewModel?.searchArticles()),
                  onSubmitted: ((value) {
                    viewModel?.searchArticles();
                  }),
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    fillColor: white,
                    hintStyle: TextStyle(color: white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: white,
                    ),
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffBEE73E)),
                    ),
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _bodyWidget(viewModel!),
                  loadingView(viewModel.isLoading),
                ],
              )),
        );
      },
      viewModelBuilder: () => SearchViewModel(),
      onViewModelReady: (SearchViewModel model) {
        model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(SearchViewModel viewModel) {
    return Container(
  color: backgroundColor,
  height: double.infinity,
  width: double.infinity,
  alignment: Alignment.topCenter,
  child: Container(
    margin: const EdgeInsets.only(left: 10, right: 10),
    child: viewModel.searchitems.isNotEmpty
      ? TabBarView(
      children: [
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewModel.searchitems.length,
          itemBuilder: (context, index) {
            Datum? blogs = viewModel.searchitems[index];
            return NewsItem(
              myCallback: () {
                viewModel.navigateToDetails(blogs);
              },
              blogs.id,
              blogs.title,
              blogs.imageName,
              blogs.description,
              blogs.articlesLink,
            );
          },
        ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewModel.searchitems.length,
          itemBuilder: (context, index) {
            Datum? blogs = viewModel.searchitems[index];
            blogs.imageName = blogs.imageName.replaceAll("35.246.127.78", "Staticprod.retailhub.ai");
            print("blogs.imageName");
            print(blogs.imageName);
            return NewsItem(
              myCallback: () {
                viewModel.navigateToDetails(blogs);
              },
              blogs.id,
              blogs.title,
              blogs.imageName,
              blogs.description,
              blogs.articlesLink,
            );
          },
        ),
      ],
    )
      : const NoDataWidget(message: 'No articles found'),
  ),
);

  }
}
