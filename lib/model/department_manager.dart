import 'package:flutter/material.dart';

class DepartmentManager {
  //initial tab to open
  String? department;

  // updating the tab
  void updateDepartment(departmentName) {
    department = departmentName;
  }
}
