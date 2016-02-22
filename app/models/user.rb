class User < ActiveRecord::Base
  before_create :create_remember_token
  before_save { email.downcase! }

  has_many :user_remember_tokens, inverse_of: :user
  # has_many :user_notes, inverse_of: :user
  # has_many :review_notes, inverse_of: :user

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  validate :check_user_flags

  scope :reviewer, -> { where(reviewer: true) }
  scope :not_reviewer, -> { where(arel_table[:reviewer].eq(nil).or(arel_table[:reviewer].eq(false))) }
  scope :admin, -> { where(admin: true) }
  scope :not_admin, -> { where(arel_table[:admin].eq(nil).or(arel_table[:admin].eq(false))) }
  scope :demo, -> { where(demo: true) }
  scope :not_demo, -> { where(arel_table[:demo].eq(nil).or(arel_table[:demo].eq(false))) }

  def self.regular
    not_admin.not_demo.not_reviewer
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    return nil if token.nil?
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.invite_review_user(email)
    user = User.new
    bad_pw = User.new_token
    user.email = email
    user.password = bad_pw
    user.password_confirmation = bad_pw
    user.password_reset_token = User.new_token
    user.password_reset_sent_at = Time.zone.now
    user.reviewer = true
    user.save

    user.invite_review_user
  end

  def invite_review_user
    if reviewer?
      unless password_reset_token.present?
        set_password_reset_token
      end
      AppLogging.say("Sending reviewer invite to #{email}")
      UserMailer.invite_review_user(self).deliver
    end
  end

  def regular?
    !admin? && !demo?
  end

  def restricted?
    demo? || email == 'aikido@aikipeace.com'
  end

  def sign_in(options={})
    options.reverse_merge!(remember_token: nil, ip: nil)

    self.remember_token = nil
    self.remember_token = User.encrypt(options[:remember_token]) if options[:remember_token]

    self.last_sign_in_at = current_sign_in_at
    self.current_sign_in_at = Time.now.utc

    self.last_sign_in_ip = current_sign_in_ip
    self.current_sign_in_ip = options[:ip] if options[:ip]

    self.sign_in_count ||= 0
    self.sign_in_count += 1

    save(validate: false)
  end

  def to_h
    # {id: id, email: email, admin: admin?, demo: demo?, regular: regular?}
    h = attributes.keys.select do |k| 
      k != "created_at" && k != "updated_at" && k != "current_sign_in_at" && k != "last_sign_in_at" && k != "password_reset_sent_at" && k != "demo_user_expires_on"
    end.map{|k| "#{k}: #{k}"}.join(', ')
    eval("{#{h}}")
  end

  #for active_admin
  def display_name
    email
  end

  def send_password_reset
    set_password_reset_token
    UserMailer.password_reset(self).deliver
  end

  private

  def set_password_reset_token
    self.password_reset_token = User.new_token
    self.password_reset_sent_at = Time.zone.now
    save(validate: false)
  end

  def check_user_flags
    errors.add(:base, 'cannot be both admin and demo user') if admin? && demo?
  end

  def create_remember_token
    self.remember_token = User.encrypt(User.new_token)
  end
end
