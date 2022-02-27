import 'package:fuodz/models/category.dart';
import 'package:fuodz/models/vendor_type.dart';

class Search {
  String type = "";
  Category category;
  VendorType vendorType;
  int vendorId;

  Search({
    this.type = "",
    this.category,
    this.vendorType,
    this.vendorId,
  });
}
