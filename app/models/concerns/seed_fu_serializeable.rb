module SeedFuSerializeable
  extend ActiveSupport::Concern

  included do
    define_method(:to_h) do
      h = attributes.keys.select{|k| k != "created_at" && k != "updated_at" }.map{|k| "#{k}: #{k}"}.join(', ')
      eval("{#{h}}")
    end
  end

  module ClassMethods
    def to_seed_fu(outfile=$stdout)
      SeedFu::Writer.write(outfile, { class_name: self.to_s, constraints: [:id]}) do |writer|
        all.order(:id).each do |obj|
          writer.add(obj.to_h)
        end
      end
    end
  end
end
