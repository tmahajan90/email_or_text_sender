class CampaignMailer < ApplicationMailer
  
  def send_email(client, campaign)
    @campaign = campaign
    mail(to: client.email, subject: @campaign.subject)


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
