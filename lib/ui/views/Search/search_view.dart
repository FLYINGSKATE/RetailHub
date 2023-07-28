import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    child: (selectedTabIndex==1?viewModel.searchedArticles.isNotEmpty:viewModel.searchedStartUps.isNotEmpty)
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

          //  String logo = "https://app.retailhub.ai/api/v2/avatar/files/112026"

           // /api/v2/avatar/files/112026
            print(startups.logoId);
            print(startups.logo30Id);
            print(startups.logo);
            print(startups.logo60);
            print(startups.logo60Id);
            print(startups.logo120);
            print(startups.logo120Id);

            print("Ashiq");
            print("https://app.retailhub.ai/api/v2/avatar/files/${startups.logo120Id}");

            //print(startups.logo.toString());
            // print(startups.toJson());
            /*print(startups.id);
            print(startups.companyShortName);
            print(startups.logoId);
            print(startups.logo30Id);
            print(startups.logo);
            print(startups.logo60);
            print(startups.logo60Id);
            print(startups.logo120);
            print(startups.logo120Id);

            print(startups.companyDescription);
            print(startups.linkedInCompanyPage);*/

            return StartUpItems(
              startups.id,
              startups.companyShortName??"No Name",
              "https://app.retailhub.ai/api/v2/avatar/files/${startups.logo30Id}"??"",
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
            blogs.imageName = blogs.imageName.replaceAll("35.246.127.78", "Staticprod.retailhub.ai");


            return StartUpItems(
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
      :  NoDataWidget(message: selectedTabIndex==1?'No articles found':'No Startups Found'),
  ),
);

  }
}


class StartUpItems extends StatefulWidget {
  final String? id, newstitle, imageUrl, newsDesc, url;
  final Function myCallback;

  const StartUpItems(
      this.id, this.newstitle, this.imageUrl, this.newsDesc, this.url,
      {Key? key, required this.myCallback})
      : super(key: key);

  @override
  State<StartUpItems> createState() => _StartUpItemsState();
}

class _StartUpItemsState extends State<StartUpItems> {

  late Future<Uint8List> myFuture;

  @override
  void initState() {
    // TODO: implement initState
    print("Initialized Ashraf");
    myFuture = _getBytes(widget.imageUrl);

    super.initState();
  }

  Future<Uint8List> _getBytes(imageUrl) async {
    Uint8List? _bytes;
    print("Ashraf we r in");

    if(kIsWeb){
      Uri uri = Uri.parse(imageUrl);
      Uint8List fileData = await http.readBytes(uri);
      return fileData;
    }
    else{
      final ByteData data = await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl);
      print("Mental Ashraf");
      _bytes = data.buffer.asUint8List();
      print(data);
      // see how byte date of the image looks like
      print("Ashraf");
      print(_bytes);
      return _bytes;
    }

    //Uint8List fileData =  Uint8List.fromList(snapshot.data!);


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (() {
            widget.myCallback();
          }),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    //color: const Color(0xFFEAF0F1),
                    child: FutureBuilder<Uint8List>(
                        future: myFuture,
                        builder: (context,AsyncSnapshot<Uint8List> snapshot) {
                          if(snapshot.hasData){
                            print("Asjr");
                            print(snapshot.data!);
                            return Image.memory(snapshot.data!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            );
                          }
                          else{
                            return const Center(
                                child: SpinKitThreeBounce(
                                  color: loadingBarcolor,
                                  size: 25.0,
                            ));
                          }

                        }
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.newstitle!,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.newsDesc!,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                color: grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // article title end
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}


