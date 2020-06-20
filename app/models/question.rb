class Question < ApplicationRecord
  require 'csv'
  require 'active_record'
  # require 'activerecord-import'
  # require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/sqlite3_adapter'
  # require 'activerecord-import'


  belongs_to :user
  has_many :comments, dependent: :delete_all



  def self.my_import(file)
    questions =[]
    puts("entered")
    puts(file.path)
    CSV.foreach(file.path, headers: true) do |row|
      puts(row)
      questions << Question.new(row.to_h)
    end
    puts(questions)
    puts("called my import")
    Question.import questions, recursive:true
  end


  include AASM

  aasm  whiny_transitions: false do
    state :created, initial: true
    state :inactive
    state :active


    event :activate  do
      transitions from: [:created, :inactive], to: :active
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end
  end
  end


