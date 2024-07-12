import 'LibraryManager.dart';

void main() async {
  LibraryManager libraryManager = LibraryManager();

  // load data at startup
  await libraryManager.loadData();

  while (true) {
    print('Library Management');
    print('1. Add Book');
    print('2. View All Books');
    print('3. Update Book');
    print('4. Delete Book');
    print('5. Search Books');
    print('6. Lend Book');
    print('7. Return Book');
    print('----------------------');
    print('8. Add Author');
    print('9. View All Authors');
    print('10. Update Author');
    print('11. Delete Author');
    print('----------------------');
    print('12. Add Member');
    print('13. View All Members');
    print('14. Update Member');
    print('15. Delete Member');
    print('16. Exit');
    print('----------------------');
    print('Enter your choice: ');
  }
}
