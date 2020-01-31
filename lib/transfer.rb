require 'pry'
require_relative "./bank_account"

class Transfer

  attr_accessor :status, :amount,  :sender, :receiver

  def initialize(sender, receiver,amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount= amount
  end
  
  def valid?
    if self.receiver.valid? && self.sender.valid? && self.amount >=0
      true
    end
  end

  def execute_transaction
      if @status == "pending" && self.receiver.status != "closed" && self.sender.balance > @amount
        self.sender.balance = self.sender.balance - @amount
        self.receiver.balance += @amount
        
        return @status = "complete"
      
      else
        @status="rejected"
        return "Transaction rejected. Please check your account balance."
      end
  end


  def reverse_transfer

     if @status=="complete" 
      self.sender.deposit(@amount)
      self.receiver.deposit(@amount * -1)
      @status="reversed"
     elsif  @status!="complete"
      return false 
     end
   
  end




end
