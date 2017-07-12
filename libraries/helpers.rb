module Tools
  require 'net/smtp'
  require 'json'
  require 'net/http'

  # Method to count how much lines of one file differ from another file
  def self.count_diff(new_file, back_file)

    nf, bf = [], []
    count = 0

    File.open(new_file, 'r').each { |line| nf.push line }
    File.open(back_file, 'r').each { |line| bf.push line }

    if nf.size != bf.size
      count = 2
    else

      i = 0
      while i < nf.size
        count += 1 unless nf[i].eql?(bf[i])
        i += 1
      end

    end

    return count

  end

  # Method to fetch data in JSON format from an URL
  def self.fetch(url)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body

    return JSON.parse(data)
  end

  # Method to unindent multiline strings
  def self.unindent string
    first = string[/\A\s*/]
    string.gsub /^#{first}/, ''
  end

  # Method to send simple emails via smtp
  def self.simple_email(to, opts={})

    opts[:server]      ||= 'smtp.office365.com'
    opts[:port]        ||= 587
    opts[:from]        ||= 'barcoder@redsis.com'
    opts[:password]    ||= 'Orion2015'
    opts[:from_alias]  ||= 'Chef Reporter'
    opts[:subject]     ||= "Chef Start on Node #{Chef.run_context.node.name}"
    opts[:message]     ||= "..."

    message = <<-MESSAGE
      From: #{opts[:from_alias]} <#{opts[:from]}>
      To: <#{to}>
      Subject: #{opts[:subject]}

      #{opts[:message]}
    MESSAGE

    mailtext = unindent message

    smtp = Net::SMTP.new(opts[:server], opts[:port])
    smtp.enable_starttls_auto
    smtp.start(opts[:server], opts[:from], opts[:password], :login)
    smtp.send_message(mailtext, opts[:from], to)
    smtp.finish

  end

end

Chef::Recipe.send(:include, Tools)
