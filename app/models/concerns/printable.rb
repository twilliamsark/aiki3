module Printable
  extend ActiveSupport::Concern

  def to_s
    name || 'n/a' rescue 'n/a'
  end
end  