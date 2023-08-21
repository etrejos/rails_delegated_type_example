# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = User.create!(name: 'Admin 1')

guests = (1..3).map { |i| User.create!(name: "Guest #{i}") }

john = User.create!(name: 'John')
mary = User.create!(name: 'Mary')

Message.create!(content: 'Message #1', user: admin).tap do |message|
  Entry.create!(entryable: message)
  guests.each do |user|
    comment = message.comments.create!(
      text: "This is a comment from #{user.name}.",
      user:
    )
    Entry.create!(entryable: comment)
  end
end

Message.create!(content: 'Message #2', user: john).tap do |message|
  Entry.create!(entryable: message)
  [guests.last, mary].each do |user|
    comment = message.comments.create!(
      text: "This is a comment from #{user.name}.",
      user:
    )
    Entry.create!(entryable: comment)
  end
end
