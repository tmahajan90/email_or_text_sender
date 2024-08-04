module EmailsHelper
    def merge_tags
      {
        '%name%' => 'The recipient\'s full name.',
        '%email%' => 'The recipient\'s email address.',
        '%mobile_no%' => 'The recipient\'s mobile number.',
        # '%company%' => 'The recipient\'s company name.',
        # '%subscription_date%' => 'The date when the recipient subscribed.'
        # Add more tags as needed
      }
    end
end
  