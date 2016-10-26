require 'print_node'

# configure the client

client = PrintNode::Client.new.tap do |config|
  config.username      = ENV['USERNAME']
  config.password      = ENV['PASSWORD']
end

# PrintPdf and get printers detail  examples

printer_detail = PrintNode::PrintJob.new

# get all printer
results = printer_detail.get_printers

#Print pdf file
params = {printer_id: 51012, title: 'Pdftitle', contentType: 'pdf_base64', content: 'http://online.wsj.com/public/resources/documents/Reprint_Samples.pdf'}
response = printer_detail.print_file(params)

#View Print Jobs
response = printer_detail.view_print_jobs