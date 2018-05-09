require_relative './string_ext'
require 'yaml'

class AccessLog

  attr_reader :email, :cmail
  attr_accessor :log_data

  def initialize(email)
    @email    = email
    @cmail    = email.alt_encrypt
    @log_data = File.exists?(log_file) ? YAML.load_file(log_file) : {}
  end

  def has_consented?
    log_data[cmail] && log_data[cmail]["consented_at"]
  end

  def consent_date
    log_data[cmail]["consented_at"]
  end

  def consented
    log_data[cmail] ||= {}
    log_data[cmail]["consented_at"] = Time.now
    save_log_data
  end

  def logged_in
    log_data[cmail] ||= {}
    log_data[cmail]["login_at"] = Time.now
    log_data[cmail]["num_logins"] = (log_data[cmail][:num_logins] || 0) + 1
    save_log_data
  end

  private

  def save_log_data
    File.open(log_file, 'w') {|f| f.puts log_data.to_yaml}
  end

  def log_file
    @log_file ||= TS.trial_dir + "/.trial_data/AccessLog.yml"
  end
end