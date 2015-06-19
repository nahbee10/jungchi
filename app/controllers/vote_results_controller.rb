class VoteResultsController < ApplicationController
  before_action :authenticate!, except: [:index, :start]
  def index

  end
  def start
    current_user = User.create()
    session[:user_id] = current_user.id
    redirect_to new_vote_result_path
  	
  end

  def new

    @user = User.find(session[:user_id])
    vote_count = @user.vote_results.all.count
    if vote_count >= 6
      redirect_to report_vote_results_path
    else
      @vote = Vote.find(vote_count+1)
      @vote_result = VoteResult.new(user: @user, vote: @vote)

    end
  end

  def create
    @vote_result = VoteResult.new(vote_result_params)
    @vote_result.user_id = params[:user_id]
    @vote_result.vote_id = params[:vote_id]

    if @vote_result.save
      redirect_to new_vote_result_path
    else
      "fuck"
    end
    # raise @vote_result.inspect
    # VoteResult.create(user: @user, vote: @vote, result: params[:result]))

  end

  def report
  	#@vote_result= VoteResult.find(session[:user_id])
  	@user = User.find(session[:user_id])
    @reporting_results = @user.make_score
  end

  private
  def vote_result_params
    params.require(:vote_result).permit(:result)
  end

  def authenticate!
    if !session[:user_id]
      redirect_to vote_results_path
    end
  end
end
