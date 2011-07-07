module Blankslate
  
   # a method for only outputting a data when a condition is true
   # useful for inserting blank slates without conditionals
   # EX: instead of doing the following
   # 
   #    if @users.blank?
   #        <p>There are no users</p>
   #    else
   #        <p>There will be users here</p>
   #    end
   # 
   # YOU CAN DO THIS :
   # 
   #    output_data_unless @users.blank? do
   #      <p>There will be users here</p>    
   #    end
   # 
   # You can also set it to output nothing by passing :output => :none :
   # 
   #    output_data_unless @users.blank?, :output => :none do
   #      <p>There will be users here</p>
   #    end
   # 
   # Isn't that more easier to read?
   
   # Customize the [default] output for the blank_slate by creating a partial at : 
   # 
   #   "app/views/blank_slates/#{name_of_controller}/#{name_of_action}"
   # 
   # You can use the rake task to generate a new blank slate:
   # 
   #   # generating a blank slate for users/index
   #   rake blank_slates:generate FOR=users/index
   # 
   # OR just pass the :message option :
   # 
   #    output_data_unless @users.blank?, :message => "No people found..."
   
   def output_data_unless(conditions,options={},&block)
     options[:message] ||= "There are no records found..."
     
     if options[:partial].nil?
       blank_slate_root = File.join(Rails.root.to_s, "app", "views", "blank_slates")
       blank_slate_path = File.join(blank_slate_root, params[:controller], 
                          "_#{params[:action]}.erb")
       partial_path = File.join("blank_slates", params[:controller], params[:action])
       blank_slate_exists = File.exists?(blank_slate_path)
       blank_slate = blank_slate_exists ? render(:partial => partial_path) : options[:message]
     else
       partial_ary = File.split options[:partial]
       file, dir = "_#{partial_ary.last}.erb", partial_ary.first
       partial_exists = File.exists? File.join(Rails.root, "app", "views", dir, file)
       blank_slate = partial_exists ? render(:partial => options[:partial]) : options[:message]
     end
     
     # rails 2.1 and after don't like the block.binding business
     v_pre_2_1 = "concat(blank_slate, block.binding)"
     v_after_2_1 = "concat(blank_slate)"
     
     if defined?(RAILS_GEM_VERSION)
       output = RAILS_GEM_VERSION.to_f > 2.1 ? v_after_2_1 : v_pre_2_1
     else
       output = v_after_2_1
     end

     conditions ? (eval(output) unless options[:output] == :none) : yield
   end
  
	 alias output_unless :output_data_unless
end
