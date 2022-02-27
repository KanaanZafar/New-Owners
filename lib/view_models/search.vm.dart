import 'package:flutter/cupertino.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/requests/search.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchViewModel extends MyBaseViewModel {
  //
  SearchRequest _searchRequest = SearchRequest();
  TextEditingController keywordTEC = TextEditingController();
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController();
  String type = "";
  Category category;
  Search search;
  //
  int queryPage = 1;
  List<Product> products = [];
  List<Service> services = [];
  List<Vendor> vendors = [];
  List<dynamic> searchResults = [];
  bool filterByProducts = true;

  SearchViewModel(BuildContext context, this.search) {
    this.viewContext = context;
    this.category = search?.category;
    this.type = search?.type;
    this.vendorType = search?.vendorType;

    if (this.category != null && this.vendorType == null) {
      this.vendorType = this.category?.vendorType;
    }

    //
    if (this.vendorType != null && this.vendorType.isService && !AppStrings.enableSingleVendor) {
      filterByProducts = false;
      type = "vendor";
      notifyListeners();
    } else if (this.vendorType != null && !AppStrings.enableSingleVendor) {
      filterByProducts = false;
      type = "vendor";
      notifyListeners();
    }
    //
    startSearch();
  }

  //
  startSearch({bool initialLoaoding = true}) async {
    //
    if (initialLoaoding) {
      setBusy(true);
      queryPage = 1;
      refreshController.refreshCompleted();
    } else {
      queryPage = queryPage + 1;
    }

    //
    try {
      final searchResult = await _searchRequest.searchRequest(
        keyword: keywordTEC.text ?? "",
        categoryId: category != null ? category.id.toString() : null,
        vendorTypeId: vendorType != null ? vendorType.id.toString() : null,
        vendorId: search?.vendorId,
        type: type,
        page: queryPage,
      );
      clearErrors();

      //
      if (initialLoaoding) {
        products = searchResult[0];
        vendors = searchResult[1];
        services = searchResult[2];
      } else {
        final mProducts = searchResult[0];
        final mVendors = searchResult[1];
        final mServices = searchResult[2];
        //
        products.addAll(mProducts as List<Product>);
        vendors.addAll(mVendors as List<Vendor>);
        services.addAll(mServices as List<Service>);
      }

      print("Data ==> $filterByProducts $services $vendors");
      if (filterByProducts &&
          this.vendorType != null &&
          this.vendorType.isService) {
        searchResults = services;
      } else if (filterByProducts) {
        searchResults = products;
      } else {
        searchResults = vendors;
      }
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    if (!initialLoaoding) {
      refreshController.loadComplete();
    }
    //done loading data
    setBusy(false);
  }

  //
  void showFilter() {}

  //
  productSelected(Product product) async {
    viewContext.navigator.pushNamed(
      AppRoutes.product,
      arguments: product,
    );
  }

  //
  vendorSelected(Vendor vendor) async {
    viewContext.navigator.pushNamed(
      AppRoutes.vendorDetails,
      arguments: vendor,
    );
  }

  void enableProductFilter() {
    filterByProducts = true;
    if (this.vendorType != null && this.vendorType.slug == "service") {
      searchResults = services;
      type = "service";
    } else {
      searchResults = products;
      type = "product";
    }
    // scrollController.animToTop();
    notifyListeners();
    startSearch();
  }

  void enableVendorFilter() {
    filterByProducts = false;
    searchResults = vendors;
    type = "vendor";
    // scrollController.animToTop();
    notifyListeners();
    startSearch();
  }
}
