import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/myappbar.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import 'tickets_viewmodel.dart';

class TicketsView extends StatefulWidget {
  const TicketsView({Key? key}) : super(key: key);
  @override
  _TicketsViewState createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, TicketsViewModel? viewModel, Widget? child) {
        return Scaffold(
            appBar: const MyAppBar(
              title: " ",
              isLogo: true,
            ),
            resizeToAvoidBottomInset: false,
            body: _bodyWidget(viewModel!));
      },
      viewModelBuilder: () => TicketsViewModel(),
      onViewModelReady: (TicketsViewModel model) {
        // model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(TicketsViewModel viewModel) {
    return Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,

        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            child: Text("No Tickets Found", style: MyTextStyle.apptitle),
          ),
        ));
  }
}
