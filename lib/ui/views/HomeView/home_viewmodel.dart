import 'package:flutter/material.dart';
import 'package:retailhub/model/tagsarticles_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../constants/API.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/route_names.dart';
import '../../../services/api_service.dart';
import '../../../services/navigation_service.dart';
import '../../../utill/helper.dart';
import '../../enums/enums.dart';
import '../../methods/basecommon_methods.dart';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

class HomeViewModel extends BaseViewModel {
  bool _isLoading = false;
  final NavigationService _navigationService = locator<NavigationService>();
  get isLoading => _isLoading;

  String? username;
  String? email;
  String? imgurl;
  String? meetingCode;
  String? currentDate;
  bool _validatemeetingtitle = false;
  bool _validatemeetingid = false;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  List<TagsArticleModel> _trainingArticles = [];
  List<TagsArticleModel> get trainingArticles => _trainingArticles;

  List<TagsArticleModel> _eventsArticles = [];
  List<TagsArticleModel> get eventsArticles => _eventsArticles;

  TextEditingController titlecontroller = TextEditingController();
  var imageList = [banner1, banner2];
  var imageList1 = [banner3, banner4];

  initModel(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString(UserDetails.email.toString()) ?? '';
    username = prefs.getString(UserDetails.fullname.toString()) ?? '';
    imgurl = prefs.getString(UserDetails.imgurl.toString());
    await getEventsArticles();
    await getTrainingArticles();
    notifyListeners();
  }

  Future<void> getEventsArticles() async {
    showProgressBar(true);
    await ApiServices.getRequest(
      url: "${API.articlesbyTag}Events",
      onSuccess: (data) async {
        showProgressBar(false);
        final searchData = tagsArticleModelFromJson(data.toString());
        _eventsArticles = searchData;
        developer.log('Length of Events Articles : ${_eventsArticles.length}');
        notifyListeners();
      },
      onError: (String message, bool isError) async {
        showProgressBar(false);
        notifyListeners();
        developer.log("ERROR$message");
      },
    );
  }

  Future<void> getTrainingArticles() async {
    showProgressBar(true);
    developer.log('Get Training Articles Api Calling..');
    await ApiServices.getRequest(
      url: "${API.articlesbyTag}Training",
      onSuccess: (data) async {
        showProgressBar(false);
        final searchData = tagsArticleModelFromJson(data.toString());
        _trainingArticles = searchData;
        developer.log('Length of Training Articles: ${_trainingArticles.length}');
        developer.log('Get Training Articles Api Called');
        notifyListeners();
      },
      onError: (String message, bool isError) async {
        showProgressBar(false);
        notifyListeners();
        developer.log("ERROR$message");
      },
    );
  }

  void navigateToDetails(TagsArticleModel blogs) {
    _navigationService.navigateTo(blogdetailsViewRoute, arguments: blogs);
  }

  showProgressBar(value) async {
    _isLoading = value;
    notifyListeners();
  }

  void navigateToPage(String eventsViewRoute) {
    _navigationService.navigateTo(eventsViewRoute);
  }
}
