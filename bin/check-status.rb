#! /usr/bin/env ruby
#
#   check-status
#
# DESCRIPTION:
#   This plugin checks that the Atlassian service status page returns a running state with status 200 OK
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: rest-client
#
# USAGE:
#   #YELLOW
#
# NOTES:
#
# LICENSE:
#   Copyright 2015, Steven Ayers sayers@equalexperts.com
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/check/cli'
require 'rest-client'

#
# Atlassian Status Checker
#
class AtlassianStatusChecker < Sensu::Plugin::Check::CLI

  option :server,
         description: 'Service Host',
         short: '-s SERVER',
         long: '--server SERVER',
         default: 'localhost'

  option :port,
         description: 'Service Port',
         short: 'p PORT',
         long: '--port PORT',
         default: '7990'

  option :https,
         short: '-h',
         long: '--https',
         boolean: true,
         description: 'Enabling https connections',
         default: false

  option :uri,
         description: 'URI for status page',
         short: '-u URI',
         long: '--uri URI',
         default: '/service/status'
  
  option :name,
         description: 'Service Name',
         short: '-n NAME',
         long: '--name NAME',
         default: 'Unknown Service'

  def run
    https ||= config[:https] ? 'https' : 'http'
    testurl = "#{https}://#{config[:server]}:#{config[:port]}#{config[:uri]}"
    r = RestClient::Resource.new(testurl, timeout: 5).get
    if r.code == 200 && r.body.include?("{\"state\":\"RUNNING\"}")
      ok "#{config[:name]} Service is up"
    else
      critical "#{config[:name]} Service is not responding"
    end
  rescue Errno::ECONNREFUSED
    critical "#{config[:name]} Service is not responding"
  rescue RestClient::RequestTimeout
    critical "#{config[:name]} Service Connection timed out"
  rescue
    critical "Couldn't get: '#{testurl}' is the server option set correctly?"
  end
end