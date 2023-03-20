class User < ApplicationRecord
  include PasswordValidation

  validates :name, presence: true

  def self.create_from_csv(csv_data)
    results = []

    CSV.parse(csv_data, headers: true) do |row|
      user = new(name: row['name'], password: row['password'])
      if user.save
        results << { name: user.name, password: user.password, status: 'success' }
      else
        results << { name: row['name'], password: row['password'], status: 'error', errors: user.errors.full_messages }
      end
    end

    results
  end
end
