class InsertTempData < ActiveRecord::Migration
  def make_vote_result(index)
    if index%3 ==0
      "yes"
    elsif index % 3 ==1
      "no"
    else
      "null"
    end
  end
  def change
    (1..6).to_a.each do |index|
      Vote.create(voted_date: '2015-06-20', title: "테스트#{index}")
    end

    (1..5).to_a.each do |index|
      repre = Representative.create(name: "의원양반#{index}")
      Vote.all.each do |vote|
        VoteResult.create(representative: repre, vote: vote, result: make_vote_result(vote.id+repre.id))
      end
    end

  end
end
