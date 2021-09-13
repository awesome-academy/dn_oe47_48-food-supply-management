class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/.freeze

  attr_accessor :remember_token
  enum role: {admin: 0, suppiler: 1, buyer: 3}

  belongs_to :town
  has_many :cart_sessions, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :full_name, presence: true,
    length: {maximum: Settings.length.max_name}
  validates :email, presence: true,
    length: {maximum: Settings.length.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :phone, presence: true,
    length: {
      minimum: Settings.length.min_phone,
      maximum: Settings.length.max_phone
    },
    format: {with: VALID_PHONE_REGEX}
  validates :password, presence: true,
    length: {minimum: Settings.length.min_password}
  has_secure_password

  before_save{email.downcase!}

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? attr, token
    digest = send("#{attr}_digest")
    return false unless digest

    BCrypt::Password.new(digest).is_password?(token)
  end
end
