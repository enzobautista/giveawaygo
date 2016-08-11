class PagesController < ApplicationController
    before_action :authenticate_user!
  def index
    @user_games = UserGame.where(user_id: current_user.id) #games played
    user_game_game_ids = []
    @user_games.each do |user_game|
      user_game_game_ids << user_game.game.id
    end
    @not_user_games = Game.where.not(id: user_game_game_ids) #array of games not played
  end

  def question
    # assume link will be game.i16.co/{qr_code}
    # assume first 2 characters of qr_code gives the game_code (ex. 53 = enzo go, 29 = jackie go
    # assume last 3 characters of qr_code gives the question_code (ex. 121 = question 1 of enzo go, 543 = question 6 of jackie go)

    game_code = params[:qr_code].at(0..1).to_i
    @game = Game.where(code: game_code).first
    if @game.present?
      if !(UserGame.where(game_id: @game.id).where(user_id: current_user.id)).present?
        UserGame.create(game_id: @game.id, user_id: current_user.id)
      end
      user_game = UserGame.where(game_id: @game.id).where(user_id: current_user.id).first
      question_code = params[:qr_code].at(-3..-1).to_i
      @question = Question.where(code: question_code).where(game_id: @game.id).first

      if @question.present?
        user_game_question = UserGameQuestion.where(user_game_id: user_game.id).where(question_id: @question.id).first
        if !user_game_question.present?
          if (@game.id == 1) #Website Go, pwede rin if game.type == "Enzo Go" kaso mas efficient if u compare integers
            if (@question.number == 1)
              @question_text = "Acc to bongbong marcos, magkano ang pamasahe ngayon sa jeep?"
              @choices = [["6 pesos",1],["4 pesos",2],["10 pesos",3]]
            elsif (@question.number == 2)
              @question_text = "What is El Nino?"
              @choices = [["Drought. We need to start planting trees and we will achieve la nina",1],["Sto Nino ba yan pit senyor!",2],["Alam ko lang nino si nino muhlach",3]]
            elsif (@question.number == 3)
              @question_text = "Who dat who dat?"
              @choices = [["La pong tao rito",1],["This is real this is me",2],["I-G-G-Y!",3]]
            elsif (@question.number == 4)
              @question_text = "Acc to bongbong marcos, magkano ang pamasahe ngayon sa jeep?"
              @choices = [["6 pesos",1],["4 pesos",2],["10 pesos",3]]
            elsif (@question.number == 5)
              @question_text = "Acc to bongbong marcos, magkano ang pamasahe ngayon sa jeep?"
              @choices = [["6 pesos",1],["4 pesos",2],["10 pesos",3]]
            else
            end
          end
          if (@game.id == 2) #Sponsors Go
            if (@question.number == 1)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 2)
              @question_text = "Do u support the RH Law?"
              @choices = [["Yes, with reservations",1],["Yes",2],["No",3]]
            elsif (@question.number == 3)
              @question_text = "What are ur reservations about the RH Law?"
              @choices = [["Ano ba ang reservations",1],["Kailangan pa ba sagutin yan?",2],["Pills!",3]]
            elsif (@question.number == 4)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 5)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            else
            end
          end
          if (@game.id == 3) #Summit Go
            if (@question.number == 1)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 2)
              @question_text = "Do u support the RH Law?"
              @choices = [["Yes, with reservations",1],["Yes",2],["No",3]]
            elsif (@question.number == 3)
              @question_text = "What are ur reservations about the RH Law?"
              @choices = [["Ano ba ang reservations",1],["Kailangan pa ba sagutin yan?",2],["Pills!",3]]
            elsif (@question.number == 4)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            else
            end
          end
          if (@game.id == 4) #Sponsors Go
            if (@question.number == 1)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 2)
              @question_text = "Do u support the RH Law?"
              @choices = [["Yes, with reservations",1],["Yes",2],["No",3]]
            elsif (@question.number == 3)
              @question_text = "What are ur reservations about the RH Law?"
              @choices = [["Ano ba ang reservations",1],["Kailangan pa ba sagutin yan?",2],["Pills!",3]]
            elsif (@question.number == 4)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 5)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 6)
              @question_text = "Do u support the RH Law?"
              @choices = [["Yes, with reservations",1],["Yes",2],["No",3]]
            elsif (@question.number == 7)
              @question_text = "What are ur reservations about the RH Law?"
              @choices = [["Ano ba ang reservations",1],["Kailangan pa ba sagutin yan?",2],["Pills!",3]]
            elsif (@question.number == 8)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 9)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 10)
              @question_text = "Do u support the RH Law?"
              @choices = [["Yes, with reservations",1],["Yes",2],["No",3]]
            elsif (@question.number == 11)
              @question_text = "What are ur reservations about the RH Law?"
              @choices = [["Ano ba ang reservations",1],["Kailangan pa ba sagutin yan?",2],["Pills!",3]]
            elsif (@question.number == 12)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 13)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            elsif (@question.number == 14)
              @question_text = "Do u support the RH Law?"
              @choices = [["Yes, with reservations",1],["Yes",2],["No",3]]
            elsif (@question.number == 15)
              @question_text = "What are ur reservations about the RH Law?"
              @choices = [["Ano ba ang reservations",1],["Kailangan pa ba sagutin yan?",2],["Pills!",3]]
            elsif (@question.number == 16)
              @question_text = "Do u feel any pressure right now?"
              @choices = [["Syempre wala! Confident!",1],["Dasal lang",2],["No i dont feel any pressure right now",3]]
            else
            end
          end
        else
          @message = "You already answered this question!"
        end
      else
        @message = "Keep on looking!"
      end
    else
      @message = "Keep on looking!"
    end
  end

  def result
    user_game = UserGame.where(game_id: params[:id1]).where(user_id: current_user.id).first
    question = Question.find(params[:id2])
    if user_game.present? && question.present?
      if question.answer == params[:answer].to_i
        UserGameQuestion.create(user_game_id: user_game.id, question_id: question.id, status: true)
        if (user_game.game.quantity == (UserGameQuestion.where(user_game_id: user_game.id).where(status: true).count))
          user_game.update(status: true)
        end
      else
        UserGameQuestion.create(user_game_id: user_game.id, question_id: question.id, status: false)
      end
    end
    redirect_to root_path
  end

  def secret
    if current_user.email == "admin@i16.co"
      @games = Game.all
    else
      redirect_to root_path
    end
  end

  def secret2
    if current_user.email == "admin@i16.co"
      @evals = Eval.all
    else
      redirect_to root_path
    end
  end

  def evals
    @eval = Eval.where(code: params[:qr_code]).first
    if (UserEval.where(user_id: current_user.id).where(eval_id: @eval.id)).present?
      @message = "You've already answered this eval form. Thanks!"
    end
  end

  def answer
    eval = Eval.find(params[:id])
    user_eval = UserEval.create(user_id: current_user.id, eval_id: eval.id, answer_a: params[:a], answer_b: params[:b], answer_c: params[:c], answer_d: params[:d], answer_e: params[:e])
    redirect_to submit_path
  end

  def submit
  end

end
