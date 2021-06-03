class Book
  attr_reader :title, :page_count

  def initialize(title, page_count)
    @title = title
    @page_count = page_count
  end
end

class Library
  BOOK_LIMIT = 18

  def initialize(books = [])
    unless books.length >= BOOK_LIMIT
      @books = books
    else
      @books = books.slice(0, BOOK_LIMIT)
    end
  end

  def look
    unless @books.empty?
      puts "Books in the Little Free Library:"
      @books.each { |book| puts "| #{book.title}" }
    else
      puts "No books in the Little Free Library."
    end
  end
  
  def take(book_title)
    to_take = @books.find_index { |book| book_title == book.title }
    unless to_take.nil?
      taken_book = @books[to_take]
      @books.delete_at(to_take)
      return taken_book
    else
      return nil
    end
  end
  
  def place(book)
    @books << book
  end

  def is_full
    @books.length >= BOOK_LIMIT
  end
end

class User
  attr_reader :name

  def initialize(name, books = [])
    @name = name
    @books = books
  end

  def look(library)
    library.look
  end

  def take(book_title, library)
    puts "User #{@name} is taking book, #{book_title}"
    book = library.take(book_title)
    unless book.nil?
      @books << book
    else
      puts "#{book_title} not in library."
    end
  end

  def place(book_title, library)
    puts "User #{@name} is placing book, #{book_title}"
    unless library.is_full
      to_place = @books.find_index { |book| book_title == book.title }
      unless to_place.nil?
        placed_book = @books[to_place]
        @books.delete_at(to_place)
        library.place(placed_book)
      else
        puts "User #{@name} is currently not holding book #{book_title}."
      end
    else
      puts "User #{@name} unable to place #{book_title} in library. Library is full."
    end
  end

  def print_books
    if @books.empty?
      puts "#{name} is not currently holding any books."
    else
      puts "#{@name} is currently holding:"
      @books.each { |book| puts "| #{book.title}" }
    end
  end
end
rodney = User.new("Rodney")
books = [Book.new("Practical OO Design in Ruby", 245), Book.new("Head First Ruby", 536)]
library = Library.new(books)
rodney.look(library)

rodney.take("Practical OO Design in Ruby", library)
rodney.print_books
rodney.look(library)

rodney.take("Head First Ruby", library)
rodney.print_books
rodney.look(library)

rodney.place("Practical OO Design in Ruby", library)
rodney.print_books
rodney.look(library)


# test max books
eighteen_books = [Book.new("Book 1", 10), \
  Book.new("Book 2", 10), \
  Book.new("Book 3", 10), \
  Book.new("Book 4", 10), \
  Book.new("Book 5", 10), \
  Book.new("Book 6", 10), \
  Book.new("Book 7", 10), \
  Book.new("Book 8", 10), \
  Book.new("Book 9", 10), \
  Book.new("Book 10", 10), \
  Book.new("Book 11", 10), \
  Book.new("Book 12", 10), \
  Book.new("Book 13", 10), \
  Book.new("Book 14", 10), \
  Book.new("Book 15", 10), \
  Book.new("Book 16", 10), \
  Book.new("Book 17", 10), \
  Book.new("Book 18", 10)]
library18 = Library.new(eighteen_books)
rodney.look(library18)
rodney.place("Head First Ruby", library18)
rodney.print_books