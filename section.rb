class Section
  attr_accessor :title, :body, :subparagraphs                                        
                                                                       
  def initialize(params)                                               
    self.title = params[:title]                                        
    self.body = params[:body]
    self.subparagraphs = params[:subparagraphs] || []
  end
                                                                       
  def to_s                                                             
    output = "\t#{title}"
    if subparagraphs.empty?
      output << " #{body}\n"
    else
      output << " #{body}\n"
      subparagraphs.each do |subparagraph|
        output << subparagraph.to_s
      end
    end
    output
  end                                                                  
end  
