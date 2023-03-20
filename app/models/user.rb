class User < ApplicationRecord
  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!.*([A-Za-z\d])\1\1).+\z/

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 10, maximum: 16 },
                       format: { with: VALID_PASSWORD_REGEX },
                       exclusion: { in: %w[111 222 333 444 555 666 777 888 999 000],
                                    message: 'cannot contain 3 repeating characters in a row' }
end
