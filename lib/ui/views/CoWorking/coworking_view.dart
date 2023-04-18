import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../model/article_model.dart';
import '../../../model/tagsarticles_model.dart';
import '../../widgets/newsitem_widget.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import 'coworking_viewmodel.dart';


class CoworkingView extends StatefulWidget {
  const CoworkingView({Key? key}) : super(key: key);
  @override
  CoworkingViewState createState() => CoworkingViewState();
}

class CoworkingViewState extends State<CoworkingView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext? context, CoworkingViewModel? viewModel,
          Widget? child) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () => Navigator.of(context!).pop(),
              ),
              title: Text(
                'CoWorking',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18.sp,
                    fontFamily: appFontFamily,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
             elevation: 0,
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
      viewModelBuilder: () => CoworkingViewModel(),
      onViewModelReady: (CoworkingViewModel model) {
        model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(CoworkingViewModel viewModel) {
   return Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child:(viewModel.articles.isNotEmpty)
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.articles.length,
                          itemBuilder: (context, index) {
                             TagsArticleModel? article = viewModel.articles[index];
                            return NewsItem(myCallback: () {
                              viewModel.navigateToDetails(article);
                            }, article!.id.toString(), article.title, article.imageName,
                                article.description,article.articlesLink);
                          })
                      : const NoDataWidget(message: 'No Coworking available')));
  }
}

