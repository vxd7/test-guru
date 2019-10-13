# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

# create! categories
categories = Category.create!([{ name: 'Backend' },
                               { name: 'Frontend' },
                               { name: 'Web development' },
                               { name: 'Design' },
                               { name: 'UI/UX' }])

# Tests
test_ruby = Test.create!(title: 'Ruby development', level: 0,
                         category_id: categories[0].id) # Category Backend
test_rails = Test.create!(title: 'Rails basics', level: 2,
                          category_id: categories[2].id) # Category Web development
test_js = Test.create!(title: 'JavaScript basics', level: 1,
                       category_id: categories[1].id) # Category Frontend

# Users
User.create!([{ name: 'John' },
              { name: 'Ann' },
              { name: 'Maria' },
              { name: 'Ruslan' }])

# Questions
# For 'Ruby development' test
q1 = Question.create!(content: 'Who created the Ruby programming language?',
                      test_id: test_ruby.id)
q2 = Question.create!(content: 'Variables in Ruby are',
                      test_id: test_ruby.id)
q3 = Question.create!(content: 'What is the name of the central management '\
                               'system for the Ruby libraries and packages?',
                      test_id: test_ruby.id)

# Answer variants
Answer.create!(content: 'John Wick', correct: false,
               question_id: q1.id)
Answer.create!(content: 'Vladimir Lenin', correct: false,
               question_id: q1.id)
Answer.create!(content: 'Bjarne Stroustrup', correct: false,
               question_id: q1.id)
Answer.create!(content: 'Yukihiro Matsumoto', correct: true,
               question_id: q1.id)

Answer.create!(content: 'Statically typed', correct: false,
               question_id: q2.id)
Answer.create!(content: 'Dynamically typed', correct: true,
               question_id: q2.id)

Answer.create!(content: 'PyPi', correct: false,
               question_id: q3.id)
Answer.create!(content: 'npm', correct: false,
               question_id: q3.id)
Answer.create!(content: 'RubyGems', correct: true,
               question_id: q3.id)

# UserTest
UserTest.create!(user_id: User.find_by(name: 'John').id, test_id: test_ruby.id)
UserTest.create!(user_id: User.find_by(name: 'John').id, test_id: test_rails.id)
UserTest.create!(user_id: User.find_by(name: 'Ann').id, test_id: test_rails.id)
UserTest.create!(user_id: User.find_by(name: 'Ann').id, test_id: test_js.id)
UserTest.create!(user_id: User.find_by(name: 'Ruslan').id, test_id: test_ruby.id)
UserTest.create!(user_id: User.find_by(name: 'Ruslan').id, test_id: test_js.id)
