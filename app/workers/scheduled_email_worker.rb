class ScheduledEmailWorker
  include Sidekiq::Worker
  
  def perform
    Campaign.where(status: 'scheduled').where('send_at <= ?', Time.current).find_each do |campaign|
      begin
        # Set status to 'sending'
        campaign.sending!

        campaign.group.clients.deliverable.each do |client|
          CampaignMailer.send_email(client, campaign).deliver_now
        end

        # Update the campaign status to 'sent' after successful processing
        campaign.sent!
        Rails.logger.error("Successfully sent email for campaign ID #{campaign.id}")
      rescue StandardError => e
        # Log error and update status to 'failed'
        Rails.logger.error("Failed to send emails for campaign ID #{campaign.id}: #{e.message}")
        campaign.failed!
      end
    end
  end
end
