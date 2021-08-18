if Rails.env.development? || Rails.env.test?
  require 'annotate'

  task :set_annotation_options do
    Annotate.set_defaults(
      position: 'after',
      models: true,
      show_indexes: true,
      simple_indexes: true,
      show_foreign_keys: true,
      show_complete_foreign_keys: false,
      with_comment: true
    )
  end

  Annotate.load_tasks
end
