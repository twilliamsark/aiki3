module Printable
  extend ActiveSupport::Concern

  def to_s
    name || 'n/a' rescue 'n/a'
  end

  def inspect
    "<#{identify(:id)}(#{name})>"
  end
end