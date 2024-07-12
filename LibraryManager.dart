import 'dart:convert';
import 'dart:io';

import 'author.dart';
import 'book.dart';
import 'member.dart';

class LibraryManager {
  List<Book> books = [];
  List<Author> authors = [];
  List<Member> members = [];

  // add a new book to the list
  void addBook(Book book) {
    books.add(book);
  }

  // return a list of book
  List<Book> viewAllBooks() {
    return books;
  }

  // identify a bok by using sbin
  void updateBook(String isbn, Book updateBook) {
    for (var i = 0; i < books.length; i++) {
      if (books[i].isbn == isbn) {
        books[i] = updateBook;
      }
    }
    print('Book with isbn not found');
  }

  // delete book by isbn
  void deleteBook(String isbn) {
    books.removeWhere((book) => book.isbn == isbn);
  }

  // search book by author
  List<Book> searchBooks({
    String? title,
  }) {
    return books.where((book) {
      return (title == null || book.title.contains(title));
    }).toList();
  }

  // lend a book to member and track due date
  void lendBook(String isbn, String memberId, String dueDate) {
    for (Book book in books) {
      if (book.isbn == isbn) {
        if (book.isLent) {
          book.isLent = true;
          book.dueDate = dueDate;
          for (Member member in members) {
            if (member.memberId == memberId) {
              member.borrowed.add(isbn);
              return;
            }
          }
        } else {
          print('Book is already lent.');
        }
      }
    }
    print('Book or Member not found.');
  }

  // Return a book and update its status
  void returnBook(String isbn) {
    for (Book book in books) {
      if (book.isbn == isbn) {
        book.isLent = false;
        book.dueDate = '';
        for (Member member in members) {
          member.borrowed.remove(isbn);
        }
      }
    }
    print('Book not found.');
  }

  // Author CRUD Operations

  // Add a new author to the list
  void addAuthor(Author author) {
    authors.add(author);
  }

  // Return a list of all authors
  List<Author> viewAllAuthors() {
    return authors;
  }

  // Update an existing author identified by name
  void updateAuthor(String name, Author updatedAuthor) {
    for (int i = 0; i < authors.length; i++) {
      if (authors[i].name == name) {
        authors[i] = updatedAuthor;
      }
    }
    print('Author with name $name not found.');
  }

  // Delete an author identified by name
  void deleteAuthor(String name) {
    authors.removeWhere((author) => author.name == name);
  }

  // Member CRUD Operations

  // Add a new member to the list
  void addMember(Member member) {
    members.add(member);
  }

  // Return a list of all members
  List<Member> viewAllMembers() {
    return members;
  }

  // Update an existing member by their member ID
  void updateMember(String memberId, Member updatedMember) {
    for (int i = 0; i < members.length; i++) {
      if (members[i].memberId == memberId) {
        members[i] = updatedMember;
      }
    }
    print('Member with ID $memberId not found.');
  }

  // Delete a member identified by their member ID
  void deleteMember(String memberId) {
    members.removeWhere((member) => member.memberId == memberId);
  }

  // Search for members by name or member ID
  List<Member> searchMembers({String? memberId}) {
    return members.where((member) {
      return (memberId == null || member.memberId.contains(memberId));
    }).toList();
  }









  // Save data to local files
  Future<void> saveData() async {
    try {
      final bookFile = File('books.json');
      final authorFile = File('authors.json');
      final memberFile = File('members.json');

      await bookFile.writeAsString(jsonEncode(books));
      await authorFile.writeAsString(jsonEncode(authors));
      await memberFile.writeAsString(jsonEncode(members));
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  // Load data from local files
  Future<void> loadData() async {
    try {
      final bookFile = File('books.json');
      final authorFile = File('authors.json');
      final memberFile = File('members.json');

      if (await bookFile.exists()) {
        final bookData = await bookFile.readAsString();
        books = List<Book>.from(
            jsonDecode(bookData).map((data) => Book.fromJson(data)));
      }

      if (await authorFile.exists()) {
        final authorData = await authorFile.readAsString();
        authors = List<Author>.from(
            jsonDecode(authorData).map((data) => Author.fromJson(data)));
      }

      if (await memberFile.exists()) {
        final memberData = await memberFile.readAsString();
        members = List<Member>.from(
            jsonDecode(memberData).map((data) => Member.fromJson(data)));
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }
}