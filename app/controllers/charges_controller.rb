class ChargesController < ApplicationController
  def new; end

  def create
    @amount = params[:amount]

    begin
      @amount = Float(@amount).round(2)
    rescue
      flash[:danger] = 'Bitte geben sie einen Betrag in CHF ein.'
      redirect_to donation_path
      return
    end

    @amount = (@amount * 100).to_i # Must be an integer!

    if @amount < 1000
      flash[:danger] = 'Ihre Spende muss mindestens 10.- CHF betragen.'
      redirect_to donation_path
      return
    end

    Stripe::Charge.create(amount: @amount, currency: 'CHF', source: params[:stripeToken], description: 'Initiativspende')

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to donation_path
  end
end
