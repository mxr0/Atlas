class Picture < ApplicationRecord

  # Extensions
  mount_uploader :file, ImageUploader

  # Methods

  def managed_by? manager, super_manager: nil # rubocop:disable Link/UnusedMethodArgument
    parent.managed_by?(manager)
  end

end
