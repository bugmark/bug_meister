require 'yaml'
require_relative "./hash_ext"

class TrialSettings
  class << self
    def method_missing(m)
      settings[m.to_sym]
    end

    def settings
      default_opts = {
        trial_dir: File.expand_path(TRIAL_DIR),
      }
      @settings ||= default_opts.multi_merge(gen_opts, base_opts, lcl_opts, participant_opts, prod_opts)
    end

    private

    def gen_opts
      dir  = File.expand_path("./.trial_data", TRIAL_DIR)
      Dir.glob("#{dir}/[a-z]*settings*.yml").reduce({}) do |acc, fn|
        acc.merge(yaml_settings(fn))
      end
    end

    def prod_opts
      base = File.expand_path("./.trial_data/Settings_prod.yml", TRIAL_DIR)
      yaml_settings(base)
    end

    def participant_opts
      base = File.expand_path("./.trial_data/Participants.yml", TRIAL_DIR)
      yaml_settings(base)
    end

    def base_opts
      base = File.expand_path("./.trial_data/Settings_base.yml", TRIAL_DIR)
      yaml_settings(base)
    end

    def lcl_opts
      base = File.expand_path("./.trial_data/Settings.yml", TRIAL_DIR)
      yaml_settings(base)
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
