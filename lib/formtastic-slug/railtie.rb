module Formtastic
  module Slug
    class Railtie < ::Rails::Railtie
      initializer 'formtastic-slug.initialize' do
        if defined?(Formtastic::Inputs)
          require 'formtastic-slug/slug_input'
        end
      end
    end
  end
end

