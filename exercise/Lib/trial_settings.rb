require 'yaml'

class TrialSettings
  class << self
    def method_missing(m)
      settings[m.to_sym]
    end

    def settings
      default_opts = {
        trial_dir: File.expand_path(TRIAL_DIR),
      }
      @settings ||= default_opts.merge(settings_hash)
    end

    private

    def settings_hash
      Dir.glob("#{TRIAL_DIR}/Settings.yml").reduce({}) do |acc, fn|
        acc.merge(yaml_settings(fn))
      end
    end

    def yaml_settings(file)
      if File.exists?(file)
        YAML.load_file(file).transform_keys {|k| k.to_sym}
      else
        {}
      end
    end
  end
end

TS = TrialSettings
