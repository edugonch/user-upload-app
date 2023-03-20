class UserImportResult
  include ActiveModel::Model

  attr_accessor :name, :password, :status, :errors

  def self.from_hash(result_hash)
    new(result_hash)
  end

  def to_partial_path
    'user_import_results/user_import_result'
  end
end