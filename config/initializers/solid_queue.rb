Rails.application.config.after_initialize do
  if defined?(SolidQueue::Record)
    SolidQueue::Record.connects_to database: { writing: :queue, reading: :queue }
  end
end