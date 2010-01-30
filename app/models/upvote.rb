class Upvote < Vote
  
  belongs_to :report, :counter_cache => :upvotes_counter
  
end
