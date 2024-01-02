class NoticesController < ApplicationController
  before_action :set_group
  before_action :check_owner, only: [:new, :create, :send_event_notice]

  def new
    @notice = Notice.new
  end

  def create
  @notice = @group.notices.new(notice_params)
  if @notice.save
    send_event_notice
    redirect_to sent_group_notice_path(@group, @notice), notice: '送信が完了しました'
  else
    render :new
  end
  end
  
  def sent
  @group = Group.find(params[:group_id])
  @notice = Notice.find(params[:notice_id])
  end

  def send_event_notice
    @group.users.each do |user|
      GroupMailer.event_notice(user, @group, @notice.title, @notice.body).deliver_now
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def check_owner
    unless @group.owner_id == current_user.id
      redirect_to root_path
    end
  end

  def notice_params
    params.require(:notice).permit(:title, :body)
  end
end
