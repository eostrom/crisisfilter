class Downvote < Vote
  
  belongs_to :report, :counter_cache => :downvotes_counter
  
end
