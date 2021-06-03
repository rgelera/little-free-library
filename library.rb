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
    taken_book = @books.reject! { |book| book_title == book.title }
    return taken_book
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
    book = library.take(book_title)
    unless book.nil?
      @books << book
    else
      puts "#{book_title} not in library."
    end
  end

  def place(book, library)
    unless library.is_full
      placed_book = @books.delete { |book| book.title == book_title }
      if placed_book
        library.place(book)
      else
        puts "User #{@name} is currently not holding book #{book_title}."
      end
    else
      puts "Unable to place #{book.title} in library. Library is full."
    end
  end

  def print_books
    @books.each { |book| puts book.title }
  end
end

rodney = User.new("Rodney")
library = Library.new([Book.new("Practical OO Design in Ruby", 245), Book.new("Head First Ruby", 536)])
rodney.look(library)

rodney.take("Practical OO Design in Ruby", library)
rodney.look(library)

rodney.take("Head First Ruby", library)
rodney.look(library)