#
# Copyright (c) 2009 ConXentric, Inc., licensed under the GPL License
# www.ConXentric.com
# This notice must be included in any derivative works
#
class CreateQuiz < ActiveRecord::Migration
  def self.up
    create_table :quizzes, :force => true do |t|
      t.string :title
      t.timestamps
    end
    
    create_table :quiz_questions, :force => true do |t|
      t.belongs_to :quiz
      t.string :question,:type      
      t.timestamps
    end
    create_table :quiz_answers, :force => true do |t|
      t.belongs_to :question
      t.belongs_to :result
      t.string :value
      t.boolean :is_correct,:default=>false,:null=>false
      t.timestamps
    end
    create_table :quiz_results, :force => true do |t|
      t.integer :user_id
      t.timestamps
    end
    
  end

  def self.down
    drop_table :quiz_results
    drop_table :quiz_answers
    drop_table :quiz_questions
    drop_table :quizzes

  end
      
end