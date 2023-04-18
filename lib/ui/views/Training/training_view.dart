import 'package:flutter/material.dart';
import 'package:retailhub/model/article_model.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../model/tagsarticles_model.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/newsitem_widget.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import '../../widgets/text_filed3.dart';
import 'training_viewmodel.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({Key? key}) : super(key: key);
  @override
  TrainingViewState createState() => TrainingViewState();
}

class TrainingViewState extends State<TrainingView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, TrainingViewModel? viewModel, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () => Navigator.of(context!).pop(),
              ),
              title: Text(
                'Training',
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
      viewModelBuilder: () => TrainingViewModel(),
      onViewModelReady: (TrainingViewModel model) {
        model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(TrainingViewModel viewModel) {
    return Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: (viewModel.articles.isNotEmpty)
                ? ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewModel.articles.length,
                    itemBuilder: (context, index) {
                      TagsArticleModel? article = viewModel.articles[index];
                      return NewsItem(myCallback: () {
                        viewModel.navigateToDetails(article);
                      },
                          article.id.toString(),
                          article.title,
                          article.imageName,
                          article.description,
                          article.articlesLink);
                    })
                : const NoDataWidget(message: 'No Training available')));
  }
}
