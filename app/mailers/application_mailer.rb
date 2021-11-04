class ApplicationMailer < ActionMailer::Base # rubocop:disable Style/FrozenStringLiteralComment
  default from: 'from@example.com'
  layout 'mailer'
end
