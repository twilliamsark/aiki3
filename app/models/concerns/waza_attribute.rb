module WazaAttribute
  extend ActiveSupport::Concern

  def to_s
    name || 'n/a'
  end
end