require 'yaml'

class TrialSettings
  class << self
    def method_missing(m)
      settings[m.to_sym]
    end

    def data
      default_opts = {
        trial_dir: File.expand_path(trial_dir),
      }
      @settings ||= default_opts.merge(settings_hash)
    end
    alias_method :settings, :data

    private

    def trial_dir
      ExerciseEnv.trial_dir
    end

    def settings_hash
      Dir.glob("#{trial_dir}/Settings.yml").reduce({}) do |acc, fn|
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
