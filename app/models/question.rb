class Question < ActiveRecord::Base
    belongs_to :category

    def self.getQuestions
    response_string = RestClient.get('https://opentdb.com/api.php?amount=50&type=boolean')
    response_hash = JSON.parse(response_string)
    questions = response_hash["results"].map do |question|
      diff = question["difficulty"]
      ques = question["question"]
      ans = question["correct_answer"].downcase == 'true' ? true : false 
      cate = question["category"]
      {diff:diff, ques:ques, ans:ans, cate:cate} 
    end
    # .find_or_create_by(category: )  
    questions.each {|q| Category.find_or_create_by(category: q[:cate]) }
    questions.map! do |q| 
        Question.create(question: q[:ques], category_id: Category.find_by(category: q[:cate]).id , correct_answer: q[:ans], difficulty: q[:diff])
    end
    end



end

# t.string "question"
# t.string "difficulty"
# t.boolean "correct_answer"
# t.integer "category_id"