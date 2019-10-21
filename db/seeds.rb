# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

# Create Users
users = User.create!([{ name: 'John', email: 'johnmail@samplemail.com' },
                      { name: 'Ann', email: 'annmail@samplemail.com' },
                      { name: 'Maria', email: 'mariamail@samplemail.com' },
                      { name: 'Ruslan', email: 'ruslanmail@samplemail.com' }])

# Create categories
categories = Category.create!([{ name: 'Backend' },
                               { name: 'Frontend' },
                               { name: 'Web development' },
                               { name: 'Design' },
                               { name: 'UI/UX' }])

# Tests
# Category Backend, author Ann
test_ruby = Test.create!(title: 'Ruby development', level: 0,
                         category: categories[0], author: users[1])
# Category Web development, author Ruslan
test_rails = Test.create!(title: 'Rails basics', level: 2,
                          category: categories[2], author: users[3])
# Category Frontend, author Maria
test_js = Test.create!(title: 'JavaScript basics', level: 1,
                       category: categories[1], author: users[2])

# Questions
# For 'Ruby development' test
q1 = Question.create!(content: 'Who created the Ruby programming language?',
                      test: test_ruby)
q2 = Question.create!(content: 'Variables in Ruby are',
                      test: test_ruby)
q3 = Question.create!(content: 'What is the name of the central management '\
                               'system for the Ruby libraries and packages?',
                      test: test_ruby)

# Answer variants
Answer.create!(content: 'John Wick', correct: false,
               question: q1)
Answer.create!(content: 'Vladimir Lenin', correct: false,
               question: q1)
Answer.create!(content: 'Bjarne Stroustrup', correct: false,
               question: q1)
Answer.create!(content: 'Yukihiro Matsumoto', correct: true,
               question: q1)

Answer.create!(content: 'Statically typed', correct: false,
               question: q2)
Answer.create!(content: 'Dynamically typed', correct: true,
               question: q2)

Answer.create!(content: 'PyPi', correct: false,
               question: q3)
Answer.create!(content: 'npm', correct: false,
               question: q3)
Answer.create!(content: 'RubyGems', correct: true,
               question: q3)

# UserTest
UserTest.create!(user: User.find_by(name: 'John'), test: test_ruby)
UserTest.create!(user: User.find_by(name: 'John'), test: test_rails)
UserTest.create!(user: User.find_by(name: 'Ann'), test: test_rails)
UserTest.create!(user: User.find_by(name: 'Ann'), test: test_js)
UserTest.create!(user: User.find_by(name: 'Ruslan'), test: test_ruby)
UserTest.create!(user: User.find_by(name: 'Ruslan'), test: test_js)
