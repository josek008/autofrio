module Shared
  module AttachmentHelper

    class << self
      def included(base)
        base.extend ClassMethods
      end
    end

    module ClassMethods
      def has_attachment(name, options = {})

        # generates a string containing the singular model name and the pluralized attachment name.
        # Examples: "user_avatars" or "asset_uploads" or "message_previews"
        attachment_owner    = self.table_name.singularize
        attachment_folder   = "#{attachment_owner}_#{name.to_s.pluralize}"

        attachment_path     = "#{attachment_folder}/:id/:style.:extension"

        if Rails.env.production?
          options[:path]            ||= attachment_path
          options[:storage]         ||= :s3
          options[:url]             ||= ':s3_domain_url'
          options[:s3_credentials]  ||= File.join(Rails.root, 'config', 'aws.yml')
          options[:s3_permissions]  ||= 'private'
          options[:s3_protocol]     ||= 'https'
        else
          # For local Dev/Test envs, use the default filesystem, but separate the environments
          # into different folders, so you can delete test files without breaking dev files.
          options[:path]  ||= ":rails_root/public/system/attachments/#{Rails.env}/#{attachment_path}"
          options[:url]   ||= "/system/attachments/#{Rails.env}/#{attachment_path}"
        end

        # pass things off to paperclip.
        has_attached_file name, options
      end
    end
  end
end