module WazaAttribute
  extend ActiveSupport::Concern
  
  def self.included klass
    klass.class_eval do
      include Printable
    end
  end
end
