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
    if params[:qr_code].at(0..1).to_i == 10
      @eval = Eval.where(code: params[:qr_code]).first
      user_evals = UserEval.where(user_id: current_user.id)
      if user_evals.count >= 5
        @message = "You've already answered evals for 5 sessions. Thank you!"
      else
        if @eval.present?
          render 'pages/evals'
        else
          @message = "Keep on looking!"
        end
      end
    else #for games
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
                @question_text = "What is our theme?"
                @choices = [["Creating Possibilities",1],["Evolving ICT: Enabling, Transforming, Redefining the Future",2],["ICT: Bolder, Broader, Easier, Faster, Stronger, Wiser",3]]
              elsif (@question.number == 2)
                @question_text = "How long has the ICT summit been running?"
                @choices = [["10 years",1],["5 years",2],["15 years",3]]
              elsif (@question.number == 3)
                @question_text = "How many Ayala Group companies are participating in the "
                @choices = [["7",1],["10",2],["13",3]]
              elsif (@question.number == 4)
                @question_text = "How many CIO forum members are there?"
                @choices = [["7",1],["10",2],["16",3]]
              elsif (@question.number == 5)
                @question_text = "How many subject tracks are there for the breakout sessions?"
                @choices = [["3",1],["6",2],["9",3]]
              else
              end
            end
            if (@game.id == 2) #Sponsors Go
              if (@question.number == 1)
                @question_text = "Which of the following companies is NOT a Platinum Sponsor"
                @choices = [["Accenture",1],["Globe Business",2],["Barhead",5],["Fis",4],["Oracle",5],["Altaire i Solutions, Inc.",6],["Huawei",7],["Brother",8],["Ramco",9]]
              elsif (@question.number == 2)
                @question_text = "Which of the following companies is NOT a Session Sponsor?"
                @choices = [["Teradata",1],["Forecasting and Planning Technologies, Inc.",2],["Tech Mahindra",3],["SAP",4],["PWC",5],["Infomax",6],["Servicenow Nexus",7]]
              elsif (@question.number == 3)
                @question_text = "Which of the following companies is a Gold Sponsor?"
                @choices = [["Fujitsu",1],["Global Sapphire Inc.",2],["Questronix",3]]
              elsif (@question.number == 4)
                @question_text = "Which of the following companies is NOT a Silver Sponsor?"
                @choices = [["Fortinet",1],["SAS",2],["Fis",3],["Network Manager",4],["Tech Mahindra",5],["Intel Security",6],["Anaplan",7],["Fujitsu",8],["Software One",9],["Trends & Technologies",10],["Brother",11]]
              elsif (@question.number == 5)
                @question_text = "Which of the following companies is NOT an Exhibit Booth Sponsor?"
                @choices = [["Accenture",1],["SMS",2],["EVI Distribution, Inc.",3],["Multicore Technology Resources, Inc.",4],["Questronix",5],["Equicom, Inc.",6],["Cloudtech",7],["Fasttrack",8],["Net4Site",9],["Inaveit",10]]
              else
              end
            end
            if (@game.id == 3) #Summit Go
              if (@question.number == 1)
                @question_text = "Who will be giving the Welcome Remarks for the Summit?"
                @choices = [["Fernando Zobel de Ayala",1],["Jaime Zobel de Ayala",2],["Jaime Augusto Zobel de Ayala",3]]
              elsif (@question.number == 2)
                @question_text = "Atty. Rodolfo Salalima is the Secretary of which newly formed Department?"
                @choices = [["Department of Information Technology",1],["Department of Information and Communications Technology",2],["Department of Transportation and Communications",3]]
              elsif (@question.number == 3)
                @question_text = "How many breakout sessions will be conducted during the Summit?"
                @choices = [["65",1],["55",2],["45",3]]
              elsif (@question.number == 4)
                @question_text = "How many exhibit booths are there in the Summit?"
                @choices = [["8",1],["18",2],["28",3]]
              else
              end
            end
            if (@game.id == 4) #CIO Members Go
              if (@question.number == 1)
                @question_text = "<center><img src='/assets/cio/cio-suzette.jpg' style='width:40vw;'></center>"
                @choices = [["Suzette B. Taala",1],["Rosalyn O. Teosoro",2],["Pebbles L. Sy-Manalang",3]]
              elsif (@question.number == 2)
                @question_text = "<center><img src='/assets/cio/cio-garcia.jpg' style='width:40vw;'></center>"
                @choices = [["Gabriel V. Tuason",1],["Rodell A. Garcia",2],["Erwin P. Locsin",3]]
              elsif (@question.number == 3)
                @question_text = "<center><img src='/assets/cio/cio-gigi.jpg' style='width:40vw;'></center>"
                @choices = [["Annie T. Alipao",1],["Olive S. Garcia",2],["Maria Angelica B. Rapadas",3]]
              elsif (@question.number == 4)
                @question_text = "<center><img src='/assets/cio/cio-rod.jpg' style='width:40vw;'></center>"
                @choices = [["Gerard R. Estrada",1],["Roderick I. Villahermosa",2],["Marino Adriano P. Encarnacion",3]]
              elsif (@question.number == 5)
                @question_text = "<center><img src='/assets/cio/cio-olive.jpg' style='width:40vw;'></center>"
                @choices = [["Pilar Bernadette C. Marquez",1],["Olive S. Garcia",2],["Pebbles L. Sy-Manalang",3]]
              elsif (@question.number == 6)
                @question_text = "<center><img src='/assets/cio/cio-erwin1.jpg' style='width:40vw;'></center>"
                @choices = [["Erwin P. Locsin",1],["Marino Adriano P. Encarnacion",2],["Gabriel V. Tuason",3]]
              elsif (@question.number == 7)
                @question_text = "<center><img src='/assets/cio/cio-vivien1.jpg' style='width:40vw;'></center>"
                @choices = [["Vivien V. Villa-Real",1],["Annie T. Alipao",2],["Rosalyn O. Teosoro",3]]
              elsif (@question.number == 8)
                @question_text = "<center><img src='/assets/cio/cio-besler.jpg' style='width:40vw;'></center>"
                @choices = [["Macjune D. Tolentino",1],["Christian Besler",2],["Gabriel V. Tuason",3]]
              elsif (@question.number == 9)
                @question_text = "<center><img src='/assets/cio/cio-pebble.jpg' style='width:40vw;'></center>"
                @choices = [["Pebbles L. Sy-Manalang",1],["Pilar Bernadette C. Marquez",2],["Annie T. Alipao",3]]
              elsif (@question.number == 10)
                @question_text = "<center><img src='/assets/cio/cio-gerard.jpg' style='width:40vw;'></center>"
                @choices = [["Marino Adriano P. Encarnacion",1],["Gabriel V. Tuason",2],["Gerard R. Estrada",3]]
              elsif (@question.number == 11)
                @question_text = "<center><img src='/assets/cio/cio-annie.jpg' style='width:40vw;'></center>"
                @choices = [["Annie T. Alipao",1],["Rosalyn O. Teosoro",2],["Suzette B. Taala",3]]
              elsif (@question.number == 12)
                @question_text = "<center><img src='/assets/cio/cio-macjune.jpg' style='width:40vw;'></center>"
                @choices = [["Macjune D. Tolentino",1],["Rodell A. Garcia",2],["Gabriel V. Tuason",3]]
              elsif (@question.number == 13)
                @question_text = "<center><img src='/assets/cio/cio-pilar.jpg' style='width:40vw;'></center>"
                @choices = [["Pebbles L. Sy-Manalang",1],["Pilar Bernadette C. Marquez",2],["Maria Angelica B. Rapadas",3]]
              elsif (@question.number == 14)
                @question_text = "<center><img src='/assets/cio/cio-gabo1.jpg' style='width:40vw;'></center>"
                @choices = [["Roderick I. Villahermosa",1],["Gabriel V. Tuason",2],["Erwin P. Locsin",3]]
              elsif (@question.number == 15)
                @question_text = "<center><img src='/assets/cio/cio-rosalyn.jpg' style='width:40vw;'></center>"
                @choices = [["Vivien V. Villa-Real",1],["Suzette B. Taala",2],["Rosalyn O. Teosoro",3]]
              elsif (@question.number == 16)
                @question_text = "<center><img src='/assets/cio/cio-mar.jpg' style='width:40vw;'></center>"
                @choices = [["Christian Besler",1],["Marino Adriano P. Encarnacion",2],["Macjune D. Tolentino",3]]
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

  def answer
    eval = Eval.find(params[:id])
    user_eval = UserEval.create(user_id: current_user.id, eval_id: eval.id, timeslot: params[:t], answer_a: params[:a], answer_b: params[:b], answer_c: params[:c], answer_d: params[:d], answer_e: params[:e])
    redirect_to submit_path
  end

  def submit
  end

end
