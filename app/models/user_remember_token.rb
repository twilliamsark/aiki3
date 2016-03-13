class UserRememberToken < ActiveRecord::Base
  include SeedFuSerializeable

  belongs_to :user, inverse_of: :user_remember_tokens

  validates_presence_of :remember_token

  attr_reader :token

  scope :signed_in, -> { where(signed_out_at: nil) }
  scope :signed_out, -> { where(arel_table[:signed_out_at].not_eq(nil)) }

  scope :not_expired, -> { where(arel_table[:expires_at].gteq(DateTime.current)) }
  scope :expired, -> { where(arel_table[:expires_at].lt(DateTime.current)) }

  scope :good, -> { signed_in.merge(not_expired) }

  def initialize(args)
    super(args)
    @token = SecureRandom.urlsafe_base64
    self.remember_token = UserRememberToken.encrypt(@token)
    self.signed_out_at = nil
  end

  def self.sign_in(user, options={})
    options.reverse_merge!(expires_at: nil, ip: nil)
    options[:ip] = options[:ip].to_s unless options[:ip].nil?
    urt = user.user_remember_tokens.create(options)
    urt.token
  end

  def self.encrypt(value)
    return nil if value.nil?
    Digest::SHA1.hexdigest(value.to_s)
  end

  def self.find_user(token)
    urt = good.find_by(remember_token: encrypt(token))
    urt.nil? ? nil : urt.user
  end

  def self.logout(token)
    urt = find_by(remember_token: encrypt(token))
    urt.update_column(:signed_out_at, DateTime.current) unless urt.nil?
  end
end
