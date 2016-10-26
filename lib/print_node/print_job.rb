require 'open-uri'
module PrintNode

  # This module provides API requests to Print Pdf files, Get printers detail,
  # View Print Pdf file jobs.

  class PrintJob

  	attr_accessor :connection

  	ALL_PRINTERS = '/printers'
    PDF_URL = '/printjobs'

    # Creates a new PrintNode::PrintJob instance.

    def initialize(connection=nil)
      @connection ||= connection || PrintNode::Client.connection
    end

    # Get all Printers

    def get_printers
      response = @connection.get ALL_PRINTERS
      result = JSON.parse(response.body)
    end

    # Print Pdf File
    # @param [Hash] options 
    # @option options [Integer] :printer_id
    #   Defines the printerId on which print is taken
    #   <b>Note that this is a mandatory parameter</b>
    # @option options [String] :title
    #   title to take the file print
    #   <b>Note that this is a mandatory parameter</b>
    # @option options [String] :contentType
    #   pass the contentType 'pdf_base64'
    #   <b>Note that this is a mandatory parameter</b>
    # @option options [String] :content
    #   pass the content as pdf online url or file path where file is stored
    #   <b>Note that this is a mandatory parameter</b>
    # @return id of print job

    def print_file(options={})
      begin
        pdf_content = open(options[:content]) {|io| io.read}
      rescue OpenURI::HTTPError
        return
      end
      main_content = Base64.encode64(pdf_content)
      params = {
        printerId:     options[:printer_id],
        title:         options[:title],
        contentType:   options[:contentType],
        content:       main_content,
        source:        "Web Interface"
      }
      response = @connection.post PDF_URL, params
    end

    #View All Print Jobs

    def view_print_jobs
      response = @connection.get PDF_URL
      result = JSON.parse(response.body)
    end

  end
end