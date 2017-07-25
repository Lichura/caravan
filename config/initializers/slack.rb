require 'slack-notifier'


SLACK = Slack::Notifier.new "#{ENV['SLACK']}"

