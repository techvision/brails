class Level
  include Mongoid::Document
  include Mongoid::Slug

  field :level_number, type: Integer
  field :level_name, type: String

  slug :level_name

  has_many :topics, dependent: :destroy 
  has_many :questions, dependent: :destroy 
  accepts_nested_attributes_for :questions, allow_destroy: true

  #validation
  validates :level_number, :level_name, :presence => true
  validates :level_number, :numericality => {:only_integer => true,  :greater_than => 0 }
  
  # Use counter_cache
  def calculate_coins_count
    topics.includes(:contents).inject(0) do |count, topic|
      count + topic.contents.inject(0) do |count, content|
        count + content.questions.inject(0) do |count, question|
          count + H_COOKIES[question.question_type]
	end
      end
    end
  end
end
