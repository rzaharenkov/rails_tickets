Rails.application.config.generators do |g|
  g.orm :active_record
  g.helper false
  g.assets false
  g.test_framework :rspec, fixtures: true,
                           model_specs: true,
                           controller_specs: true,
                           view_specs: false,
                           helper_specs: false,
                           routing_specs: false

  g.fixture_replacement :factory_girl, dir: 'spec/factories'

  g.template_engine :slim
end
