import 'package:flutter/material.dart';
import 'package:retailhub/ui/widgets/myappbar.dart';
import 'package:stacked/stacked.dart';
import '../../../constants/app_colors.dart';
import '../../../model/events_model.dart';
import '../../widgets/newsitem_widget.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import 'events_viewmodel.dart';


class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);
  @override
  EventsViewState createState() => EventsViewState();
}

class EventsViewState extends State<EventsView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, EventsViewModel? viewModel, Widget? child) {
        return Scaffold(
            appBar: const MyAppBar(title: "Events",isLogo:false),
            resizeToAvoidBottomInset: false,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _bodyWidget(viewModel!),
                loadingView(viewModel.isLoading),
              ],
            ));
      },
      viewModelBuilder: () => EventsViewModel(),
      onViewModelReady: (EventsViewModel model) {
        model.initModel(context);
      },
    );
  }

 
  Widget _bodyWidget(EventsViewModel viewModel) {
   return Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: (viewModel.eventsitems.isNotEmpty)
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewModel.eventsitems.length,
                          itemBuilder: (context, index) {
                            EventsModel? blogs = viewModel.eventsitems[index];
                            return NewsItem(myCallback: () {
                              viewModel.navigateToDetails(blogs);
                            }, blogs.id.toString(), blogs.title, blogs.imgur,
                                blogs.desc,blogs.articleurl);
                          })
                      : const NoDataWidget(message: 'No Event available')));
  }
}

