unless defined?($totango)
  $totango = if Rails.env.production?
    Totangorb::Tracker.new('1234xxxx')
  else
    Totangorb::Tracker.new('1234xxxx', debug: true, logger: Rails.logger)
  end
end
