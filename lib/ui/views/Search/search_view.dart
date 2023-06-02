import 'package:flutter/material.dart';
import 'package:retailhub/constants/app_colors.dart';
import 'package:retailhub/model/startup_model.dart';
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

  late TabController tabBarController;
  int selectedTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    tabBarController = TabController(vsync: this, length: 2);
    tabBarController.addListener(() {
      setState(() {
        //Call Apis Accordingly
        selectedTabIndex = tabBarController.index;

      });
      print("Selected Index: " + tabBarController.index.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext? context, SearchViewModel? viewModel, Widget? child) {
        return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              bottom: TabBar(
                onTap: (index){
                  print("Tab Index Change Hua ");
                  if(viewModel?.searchController.text.trim()==""){
                    if(index==0){
                      viewModel?.getAllStartups();
                    }
                    else{
                      viewModel?.getAllArticles();
                    }
                  }
                  else{
                    if(index==0){
                      viewModel?.searchStartups();
                    }
                    else{
                      viewModel?.searchArticles();
                    }
                  }
                },
                controller: tabBarController,
                indicatorColor: primaryColor,
                tabs: [
                  Tab(text: "Startups"),
                  Tab(text: "Articles")
                ],
              ),
              backgroundColor: backgroundColor,
              title: TextField(
                autofocus: true,
                controller: viewModel?.searchController,
                style: const TextStyle(color: white),
                textInputAction: TextInputAction.search,
                onChanged: (ss) {
                  viewModel?.searchArticles();
                },
                onEditingComplete: (() {
                  if(viewModel?.searchController.text.trim()==""){
                    if(selectedTabIndex==0){
                      viewModel?.getAllStartups();
                    }
                    else{
                      viewModel?.getAllArticles();
                    }
                  }
                  else{
                    if(selectedTabIndex==0){
                      viewModel?.searchStartups();
                    }
                    else{
                      viewModel?.searchArticles();
                    }
                  }
                }) ,
                onSubmitted: ((value) {
                  print("selectedTabIndex");
                  print(selectedTabIndex);
                  if(viewModel?.searchController.text.trim()==""){
                    if(selectedTabIndex==0){
                      viewModel?.getAllStartups();
                    }
                    else{
                      viewModel?.getAllArticles();
                    }
                  }
                  else{
                    if(selectedTabIndex==0){
                      viewModel?.searchStartups();
                    }
                    else{
                      viewModel?.searchArticles();
                    }
                  }

                }),
                decoration:  InputDecoration(
                  hintText: "Search...",
                  fillColor: white,
                  suffixIconColor: Colors.white,
                  hintStyle: TextStyle(color: white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: white,
                  ),
                  suffixIcon: (viewModel?.searchController.text.isEmpty??false)?null:IconButton(onPressed: ()
                  {
                    viewModel?.searchController.clear();
                  }, icon: Icon(Icons.close,color: white,)),
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
            ));
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
    child: viewModel.searchedArticles.isNotEmpty
      ? TabBarView(
      controller: tabBarController,
      children: [
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewModel.searchedStartUps.length,
          itemBuilder: (context, index) {
            Startups? startups = viewModel.searchedStartUps[index];
            //startups.imageName = blogs.imageName.replaceAll("35.246.127.78", "Staticprod.retailhub.ai");
            print("startups.logo");
          //  print(startups.logo.toString());
           // print(startups.toJson());
            print(startups.id);
            print(startups.companyShortName);
            print(startups.logoId);
            print(startups.logo30Id);
            print(startups.logo);
            print(startups.logo60);
            print(startups.logo60Id);
            print(startups.logo120);
            print(startups.logo120Id);

            print(startups.companyDescription);
            print(startups.linkedInCompanyPage);
            return NewsItem(
              startups.id,
              startups.companyShortName??"No Name",
              startups.logo??"",
              startups.companyDescription.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
              startups.linkedInCompanyPage, myCallback: (){
                viewModel.navigateToStartupDetails(startups);
            },
            );
          },
        ),
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: viewModel.searchedArticles.length,
          itemBuilder: (context, index) {
            Datum? blogs = viewModel.searchedArticles[index];
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
