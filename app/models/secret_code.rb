class SecretCode < ApplicationRecord

  attr_accessor :bulk_generate

  validates :bulk_generate, inclusion: { in: 1..100, message: 'The SecretCode number must be between 1 and 100' }

  has_one :user


  # change order number starting from R to S
  before_validation(on: :create) do
    self.code = NumberGenerator.new(prefix: 'E').send(:generate_permalink, SecretCode)
  end

  # change order number starting from R to S
  before_validation(on: :create) do
    self.bulk_generate = self.bulk_generate.blank? ? 1 : self.bulk_generate.to_i
  end

  def self.get_unuse_code
    left_outer_joins(:user).where( users: { id: nil }).first
  end

end
