#
# ActiveResource Models for the meetup.com api.
#

class MeetupResource < ActiveResource::Base

  self.site = "http://api.meetup.com/2/"

  attr_accessor :api_key


  #if RAILS_ENV != 'production' 
    ActiveResource::Base.logger = Rails.logger
  #end
  
  # Get your API key at http://www.meetup.com/meetup_api/key/?op=reset
  MEETUP_API_KEY = APPLICATION_CONFIG['meetup_api_key']

  # Meetup API Limits: http://www.meetup.com/meetup_api/docs/#limits
  API_MAX_RESULTS = 200

  def self.inherited(clazz)
    # e.g. MeetupGroup.element_name = 'group'
    clazz.send('element_name=', clazz.name.sub(/^Meetup/,"").downcase)
  end


  module MeetupXmlFormat
    extend self

    def extension 
      "xml"
    end

    def mime_type
      "application/xml"
    end

    def decode(xml)
      from_xml_data(
        (Hash.from_xml(xml)["results"]["items"] || {}).values.first)
    end

    private
    # Manipulate from_xml Hash, because xml_simple is not exactly what we
    # want for ActiveResource.
    def from_xml_data(data)
      if data.is_a?(Hash) 
        Array.new.push(data)
      else
        data
      end
    end

  end

  self.format = MeetupResource::MeetupXmlFormat

  def self.find(scope, args = {})
    if args[:params]
      args[:params].merge!({:key => @api_key || MEETUP_API_KEY })
    end
    super(scope, args)
  end


  # pagination code originally from http://developer.37signals.com/highrise/highrise.rb
  #
  def self.find_everything(options = {})
    records = []
    each(options) { |record| records << record }
    records
  end

  def self.each(options = {})
    options[:params] ||= {}
    options[:params][:offset] = 0
    options[:params][:page] = API_MAX_RESULTS 

    loop do
      if (records = self.find(:all, options)).any?
        records.each { |record| yield record }
        if records.size < API_MAX_RESULTS
          break
        else
          options[:params][:offset] += 1
        end
      else
        break # no people included on that page, thus no more people total
      end
    end
  end


end

