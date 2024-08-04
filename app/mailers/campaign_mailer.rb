class CampaignMailer < ApplicationMailer
  
  def send_email(client, campaign)
    @campaign = campaign
    email_body = client.personalize_email(@campaign.email_template, client.email)
    mail(to: client.email, subject: @campaign.subject, body: email_body )

    # Log the email delivery
    if client && client.email
      EmailDelivery.create(
        campaign: @campaign,
        client: client,
        status: 'sent'
      )
    end
  rescue StandardError => e
    Rails.logger.error("Failed to send email to #{client.email}: #{e.message} : for campaign #{@campaign.id}")
    if client
      EmailDelivery.create(
        campaign: @campaign,
        client: client,
        status: 'failed',
        failure_reason: e.message
      )
    end
  end
end
