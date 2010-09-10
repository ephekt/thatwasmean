class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing
  
  after_create :tally_votes
  after_save :tally_votes
  
  named_scope :for, lambda { |thing_id| { :conditions => { :thing_id => thing_id, :for => 1 } } }
  named_scope :against, lambda { |thing_id| { :conditions => { :thing_id => thing_id, :for => 0 } } }
  
  def self.add_new_vote thing, user_ip, direction
    
    user = User.find_by_ip(user_ip)

    if user.nil?
      user = User.new(:ip => user_ip)
      vote = user.votes.build(:thing => thing, :for => direction)
      user.save!
    else
      vote = Vote.find(:all, :conditions => "user_id = #{user.id} AND thing_id = #{thing.id}", :limit => 1 )
      if vote.nil? || vote.empty?
        user.votes.build(:thing => thing, :for => direction)
        user.save!
      else
        vote[0].update_attribute(:for, direction)
        true
      end
    end
    
  end
  
  private
  
  def tally_votes
    @thing = Thing.find_by_id(self.thing_id)
    count = Vote.for(@thing.id).count - Vote.against(@thing.id).count
    @thing.update_attribute(:current_votes, count)
  end
  
end
