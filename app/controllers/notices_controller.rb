class NoticesController < ApplicationController
  before_action :set_group
  before_action :check_owner, only: [:new, :create, :send_event_notice]

  def new
    @notice = Notice.new
  end

  def create
    @notice = @group.notices.new(notice_params)
    if @notice.save
      redirect_to @group, notice: '送信が完了しました'
    else
      render :new
    end
  end
  
  def send_event_notice
    @group.users.each do |user|
      GroupMailer.event_notice(user, @group, params[:event_title], params[:event_body]).deliver_now
    end
    redirect_to @group, notice: '送信が完了しました'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def check_owner
    redirect_to root_path unless @group.owner_id == current_user.id
  end

  def notice_params
    params.require(:notice).permit(:title, :body)
  end
end

