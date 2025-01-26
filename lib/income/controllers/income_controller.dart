import 'package:fintrack/core/models/category.dart';
import 'package:fintrack/core/models/category_line.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController {
  var totalIncome = 2000.0.obs;
  var isEditing = false.obs;

  var categories = <Category>[
    Category(
      title: 'Salary',
      lines: [
        CategoryLine(name: 'Company 1', amount: 1200.0),
        CategoryLine(name: 'Company 2', amount: 800.0),
      ],
    ),
  ].obs;

  void toggleShaking() {
    isEditing.value = !isEditing.value;
  }

  void addCategory(String title, List<CategoryLine> lines) {
    categories.add(Category(title: title, lines: lines));
    updateTotalIncome();
  }

  void addCompanyToCategory(String categoryTitle, String name, double amount) {
    var category = categories.firstWhere((cat) => cat.title == categoryTitle);
    category.lines.add(CategoryLine(name: name, amount: amount));
    updateTotalIncome();
  }

  void removeCompanyFromCategory(String categoryTitle, int index) {
    var category = categories.firstWhere((cat) => cat.title == categoryTitle);
    category.lines.removeAt(index);
    updateTotalIncome();
  }

  void updateTotalIncome() {
    totalIncome.value = categories.fold(
      0.0,
      (sum, category) =>
          sum + category.lines.fold(0.0, (sum, line) => sum + line.amount),
    );
  }

  void updateCategoryTitle(String newTitle, int index) {
    categories[index] = Category(
      title: newTitle,
      lines: categories[index].lines,
    );
    update();
  }

  void updateCategoryLine(
      int categoryIndex, int lineIndex, String newName, double newAmount) {
    final lines = categories[categoryIndex].lines;

    final updatedLines = List<CategoryLine>.from(lines);
    updatedLines[lineIndex] = CategoryLine(name: newName, amount: newAmount);

    categories[categoryIndex] = Category(
      title: categories[categoryIndex].title,
      lines: updatedLines,
    );

    updateTotalIncome();
    update();
  }
}
