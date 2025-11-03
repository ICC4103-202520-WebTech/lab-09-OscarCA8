Rails.application.config.after_initialize do
  if defined?(SolidQueue::Record)
    SolidQueue::Record.connects_to(
      writing: ActiveRecord::Base.configurations.configs_for(env_name: Rails.env).find { |c| c.name == "queue" }.name.to_sym
    )
  end
end
