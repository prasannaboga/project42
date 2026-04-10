class DocumentTemplate
  attr_accessor :title, :header, :footer, :content_items, :company_name, :date

  def initialize
    @title = "Document"
    @header = ""
    @footer = "Confidential"
    @content_items = []
    @company_name = "My Company"
    @date = Time.now.iso8601
  end

  def clone
    super.tap do |copy|
      copy.content_items = @content_items.dup
    end
  end

  def render
    puts @title
    puts "═" * 70
    puts @header
    puts "\n"

    @content_items.each do |item|
      puts item
    end

    puts "\n"
    puts "Company: #{@company_name}"
    puts "Date:    #{@date}"
    puts "═" * 70
    puts @footer
    puts "═" * 70
  end
end

class InvoiceTemplate < DocumentTemplate
  attr_writer :invoice_number

  def initialize
    super
    @title = "INVOICE"
    @header = "INVOICE NO: #{@invoice_number}"
    @content_items = [
      "Line item 1",
      "Line item 2",
      "Line item 3",
      "Line item 4"
    ]
    @footer = "Invoice"
  end
end

class MonthlyReportTemplate < DocumentTemplate
  def initialize
    super
    @title = "MONTHLY PERFORMANCE REPORT"
    @header = "Report header"
    @content_items = [
      "Report item 1",
      "Report item 2",
      "Report item 3",
      "Report item 4"
    ]
    @footer = "Internal Use Only"
  end

  attr_writer :month, :year
end

invoice_template = InvoiceTemplate.new
invoice = invoice_template.clone
invoice.invoice_number = "INV-12345"
invoice.content_items << "Line item 5"
invoice.date = "2026-02-12"
invoice.render

report_template = MonthlyReportTemplate.new
report = report_template.clone
report.content_items << "Report item 5"
report.date = "2026-02-12"
report.render
