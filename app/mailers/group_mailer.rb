class GroupMailer < ApplicationMailer
  default from: 'from@example.com'

  def event_notice(user, group, event_title, event_body)
    @user = user
    @group = group
    @event_title = event_title
    @event_body = event_body

    mail to: user.email, subject: "【#{group.name}】イベント通知"
  end
end
