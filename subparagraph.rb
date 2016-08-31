class Subparagraph
  attr_accessor :title, :body                                          
                                                                       
  def initialize(params)                                               
    self.title = params[:title]                                        
    self.body = params[:body]                                          
  end                                                                  
                                                                       
  def to_s                                                             
    "\t\t#{title} #{body}\n"                                             
  end                                                                  
end  
