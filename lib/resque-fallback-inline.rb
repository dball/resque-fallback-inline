require "resque-fallback-inline/version"

module ResqueFallbackInline

  def enqueue(*args)
    super
  rescue Errno::ECONNREFUSED => e
    unless Resque.inline?
      begin
        Resque.inline = true
        super
      ensure
        Resque.inline = false
      end
    else
      raise e
    end
  end

end

Resque.extend(ResqueFallbackInline)
