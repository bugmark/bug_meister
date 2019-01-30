require 'dotenv'

class ExerciseEnv

  class << self

    # returns the trial directory
    # can be specified via:
    # 1) environment variable "TRIAL_DATA"
    # 2) the TRIAL_DATA setting in a .env file
    # 3) the default setting "<application>/trial"
    def trial_dir(path = nil)
      return File.expand_path(ENV["TRIAL_DATA"]) if ENV["TRIAL_DATA"]
      return default_trial_dir if path.nil?
      Dotenv.load(env_file_in_parent(path))
      ENV["TRIAL_DIR"] || default_trial_dir
    end

    private

    def default_trial_dir
      cwd = Dir.getwd
      base        = File.expand_path("./trial", cwd)
      parent      = File.expand_path("../trial", cwd)
      grandparent = File.expand_path("../../trial", cwd)
      targets = [base, parent, grandparent]
      result = Dir.glob(targets).first
      raise "ERROR: default trial_dir not found" unless result
      result
    end

    def env_file_in_parent(path)
      base        = File.expand_path("./.env", path)
      parent      = File.expand_path("../.env", path)
      grandparent = File.expand_path("../../.env", path)
      targets = [base, parent, grandparent]
      result = Dir.glob(targets).first
      raise "ERROR: .env file not found" unless result
      result
    end

  end

end
