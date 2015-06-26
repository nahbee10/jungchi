class User < ActiveRecord::Base
  has_many :vote_results

	def make_score
    user_result= self.vote_results
    result_a = []
    Representative.all.each do |r|
      count = 0
      r.vote_results.each do |r_vote_result|
        user_result.each do |a_user_result|
          if r_vote_result.vote_id == a_user_result.vote_id && result_compare(a_user_result.result, r_vote_result.result)
            count +=1
          end
        end
      end
      result_a.push({representative: r, count: count})
    end
    result_a


  end

  def result_compare(i,j)
    if i=="bandae" || i=="gigwon"
      j=="bandae" || j=="gigwon"
    else
      i==j
    end
  end

end

