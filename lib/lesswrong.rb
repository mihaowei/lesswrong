require 'Nokogiri'
require 'open-uri'
require 'launchy'
require 'pry'

url = URI('https://wiki.lesswrong.com/wiki/Sequences')
html = Nokogiri::HTML(open(url))
books_node = html.css('li')

# fill hash with book names and urls
books_hash = {}

books_node.each do |n|
  if n.inner_text.include?("Book") && !n.css('a').empty?
    books_hash[n.text.lines.first] = "https://wiki.lesswrong.com#{n.css('a').attribute('href')}"
  end
end

puts "Welcome to the lesswrong sequences"
puts "Select a book by number (1-6) or randomize your selection (random)"
puts books_hash.keys

user_input = gets.chomp

book_toggle = false

while book_toggle != true
  if user_input == "random"
    user_input = rand(1..6)
    book_toggle = true
  elsif user_input.to_i.between?(1, 6)
    break
  else
    puts "Invalid input"
    user_input = gets.chomp
  end
end

puts "You have selected #{books_hash.keys[user_input.to_i - 1]}"

new_html = Nokogiri::HTML(open(books_hash.values[user_input.to_i - 1]).read)
book_node = new_html.css('div#toc')

chapters = {}
book_node.css('li a').each do |n|
  chapters[n.inner_text] = "#{books_hash.values[user_input.to_i - 1]}#{n.attribute('href')}"
end

puts "Book #{user_input} has #{chapters.length} chapters: "
puts "Select a chapter by number (1-#{chapters.length}) or randomize your selection (random)"
puts chapters.keys

user_input = gets.chomp

chapter_toggle = false

while chapter_toggle != true
  if user_input == "random"
    user_input = rand(1..chapters.length)
    chapter_toggle = true
  elsif user_input.to_i.between?(1, chapters.length)
    break
  else
    puts "Invalid input"
    user_input = gets.chomp
  end
end

articles = new_html.css('dl')[user_input.to_i - 1].inner_text.split("\n\n")
articles.map! { |article| article.gsub(/\n/, "") }

article_hash = {}

new_html.css('dl').each do |n|
  articles.each do |a|
    if n.inner_text.include?(a)
      article_hash[a] = "#{n.css('a').attribute('href')}"
    end
  end
end

puts "You have selected chapter #{chapters.keys[user_input.to_i - 1]}"
puts "#{chapters.keys[user_input.to_i - 1]} has #{article_hash.length} articles:"
puts "Select an article by number (1-#{article_hash.length}) or randomize your selection (random)"
puts article_hash.keys

user_input = gets.chomp

article_toggle = false

while article_toggle != true
  if user_input == "random"
    user_input = rand(1..article_hash.length)
    article_toggle = true
  elsif user_input.to_i.between?(1, article_hash.length)
    break
  else
    puts "Invalid input"
    user_input = gets.chomp
  end
end

puts "You have selected article #{article_hash.keys[user_input.to_i - 1]}"
puts article_hash.values[user_input.to_i - 1]

Launchy.open(article_hash.values[user_input.to_i - 1])
