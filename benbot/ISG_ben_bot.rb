# encoding: utf-8

require 'rubygems'
require 'telegram/bot'

logger = Logger.new(STDOUT, Logger::DEBUG)
token = 'INSERISCI QUI IL TOKEN OTTENUTO DAL BOT FATHER'      # INSERISCI QUI IL TOKEN OTTENUTO DAL BOT FATHER

logger.info("Avvio del Bot")

#### METODI
### Gestione testo e messaggio
def regolamento (message)
  saluto = "Ciao, " + b(nome(message))+", hai chiesto il regolamento: \n\n"
  head = ""

headdevs = "Questo gruppo nasce per lo studio dei linguaggi per le tecniche di programmazione e per lo scambio di informazioni e di codice."
headruby = "Questo gruppo nasce per lo studio del linguaggio RUBY, per le tecniche di programmazione e per lo scambio di informazioni e di codice."
headlinux = "Lo scopo del canale pubblico LINUX HELP ITALIA e' di creare un punto di ritrovo fra esperti e meno esperti ,per discutere delle problematiche o proporre soluzioni attraverso le proprie esperienze riguardo il noto sistema operativo Linux e di tutte le sue distribuzioni comunemente chiamate 'derivate'."

corpo =
"\n\nRegolamento:

- In questo gruppo, non e' tollerato ne' lo spamming ne' il flooding ne' l'OT (offtopic) di ogni genere chi floodda verra' segnalato.
- Sono severamente vietate le bestemmie, gli insulti ed ogni forma di volgarita'.
- Non creare per nessun motivo ne' diatribe personali ne' guerre di opinione per futili motivi.
- Non essere mai sgradevoli con gli altri per nessun motivo.
- Il bullismo non sara' tollerato in nessun caso. Ed i bulli vengono sempre segnalati alle autorita' competenti.
- Il supergenio di turno non sara' tollerato! L'umilta' e' una grande virtu'! PRATICARLA FA BENE!
- Non pubblicare ne' su questo gruppo ne' su altri informazioni provenienti da chat personali.

<b>- NE' IL GRUPPO NE' I SUOI AMMINISTRATORI SONO RESPONSABILI DIRETTAMENTE O INDIRETTAMENTE PER EVENTUALI CONDOTTE SCORRETTE O INDECENTI DEGLI UTENTI.</b>

- Chiunque viola il regolamento verra' bannato senza alcun preavviso ed ogni sua conversazione molesta verra' cancellata. Sara' come se non fosse mai esistito."

inc = ""

incdevs =
"\n\n* E' gradito ed e' incoraggiato lo scambio di informazioni relative ad ogni linguaggio di programmazione.

* Incoraggiamo ogni membro a parlare di ogni aspetto inerente ad un dato linguaggio e ad eventuali framework ad esso collegati."

incruby =
"\n\n* E' gradito ed e' incoraggiato lo scambio di informazioni relative al linguaggio RUBY.

* Incoraggiamo ogni membro a parlare di ogni aspetto inerente al linguaggio ed ai framework collegati come Ror (ruby on rails) ed altri."

inclinux =
"\n\n* E' gradito ed e' incoraggiato lo scambio di informazioni relative ad ogni distribuzione di Linux senza nessuna forma di preferenza"

piede =
"\n\n* Anche la goliardia se e' civile e divertente, viene incoraggiata. Non siamo bacchettoni. Ci piace scherzare ed amiamo le compagnie gradevoli e brillanti.

* Vogliamo evitare ad ogni costo i flame violenti, ma lo scambio di opinioni anche se e' forte non ci spaventa.

Per la buona e civile convivenza su questo gruppo abbiamo deciso di utilizzare come regolamento la <b>netiquette</b>.

Altre info:
- Per le richieste di aiuto e' necessario utilizzare i tag. L'utilizzo dei tag permette ad altri membri di cercare argomenti o problemi eventualmente gia' trattati."

tag = ""

tagruby =
"\n\nEsempio con tag #solved: dal menu con 3 puntini in alto a destra si fa la ricerca con il tag #solved.
Per post su un dato argomento(topic) mettendo il tag all'inizio del post #classe #singleton ecc...."

taglinux =
"\n\nEsempio con tag #solved: dal menu con 3 puntini in alto a destra si fa la ricerca con il tag #solved.
Per post su archilinux problema xorg mettiamo ainizio post #archlinux #xorg."

base =
"\n\n* Il buongiorno e' sempre gradito come tutte le buone maniere.

<b>QUESTO GRUPPO NASCE CON L'INTENTO E LA VISIONE: CHE OGNI PERSONA HA IL DIRITTO DI ACCEDERE ALLA CONOSCENZA.
CHI LA POSSIEDE HA IL DOVERE MORALE ED ETICO DI AIUTARE IL PROSSIMO A CRESCERE E MIGLIORARE!</b>"

chatid = chatid(message).to_s

# QUESTO PASSAGGIO ADATTA IL REGOLAMENTO AL GRUPPO IN CUI VIENE RICHIESTO.
# PER IL MOMENTO SONO PIENAMENTE SUPPORTATI DUE GRUPPI SUI QUALI IL BOT OPERA.

chatruby = ""      # INSERISCI QUI L'ID DELLA CHAT
chatdevs = ""      # INSERISCI QUI L'ID DELLA CHAT
chatlinux = ""     # INSERISCI QUI L'ID DELLA CHAT

    if chatid == chatruby
        head = headruby
        inc = incruby
        tag = tagruby # stesso per devs e ruby
    end

    if chatid == chatdevs
        head = headdevs
        inc = incdevs
        tag = tagruby # stesso per devs e ruby
    end
  
    if chatid == chatlinux
        head = headlinux
        inc = inclinux
        tag = taglinux
    end

    msg = saluto + head + corpo + inc + piede + tag + base
end

def b (messaggio)                           # testo BOLD
    b = "<b>"+messaggio.to_s+"</b>"
end

def i (messaggio)                           # testo ITALIC
    i = "<i>"+messaggio.to_s+"</i>"
end

def pulisci (messaggio)                     # utilizza gli HTML special CHARS
    messaggio = messaggio.gsub "&", "&amp;"
    messaggio = messaggio.gsub "<", "&lt;"
    messaggio = messaggio.gsub ">", "&gt;"
    messaggio
end

def status (sts)                            # Ridefinisce lo status in italiano
    res = "Utente"
    case sts
    when "creator"
        res = "Proprietario"
    when "administrator"
        res = "Amministratore"
    else
    end
    res
end

def msg (chatid, messaggio, bot)            # Invia il messaggio
    bot.api.send_message(chat_id: chatid, text: messaggio, parse_mode: "HTML") # parse_mode: Markdown
end

### Informazioni
## Chat
def title (message)                         # Titolo CHAT
    title = pulisci(message.chat.title)
end

def chatid (message)                        # Id CHAT
    message.chat.id
end

## Utente
def nome (message)                          # Nome Utente
    nome = pulisci(message.from.first_name)
end

def id (message)                            # Id Utente
    message.from.id
end

def user (message)
    user = message.from.username
    user = "NESSUNO\nCREANE UNO AL PIU' PRESTO!" if user.nil?
end

def me (bot)
    infome = bot.api.getMe
    me = infome['result']['id'].to_s
    me
end

### LOGGING SU TERMINALE
def risp (messaggio, userid)                           # Assembla una risposta minimale per il log
    testo = "Risposta: " + messaggio +
            "UID : " + userid.to_s
end

def s_log (nome, chatid, bot, message, res)         # Prepara ed invia il log alla console
    print "METODO: ",nome," ::"
    print "\nARGOMENTI:"
    print "\nchatid: ",chatid
    print "\nbot: ",bot
    print "\nmessage: ",message
    puts
    puts "RISULTATO: ",res
end


### ACTIONS
def kick (chatid, userid, bot)                      # Kikka ma non banna
    bot.api.kick_chat_member(chat_id: chatid, user_id: userid)
    bot.api.unban_chat_member(chat_id: chatid, user_id: userid)
end


def ban (chatid, userid, bot)                       # Banna!
    bot.api.kick_chat_member(chat_id: chatid, user_id: userid)
end

### Controlli per gli ADMINS

def chat_admins (chatid, bot, message)              # Crea un'array con gli amministratori
    nome = "chat_admins"
    resp = bot.api.get_chat_administrators(chat_id: chatid)
    arr_adm = resp['result']
    ret = Array.new
    arr_adm.each do |adm|
        temp = {
            'id' => adm['user']['id'].to_s,
            'nome' => pulisci(adm['user']['first_name']),
            'user' => adm['user']['username'],
            'status' => status(adm['status'])
        }
        ret.push(temp)
    end
    s_log(nome, chatid, bot, message, ret)
    ret
end

def lista_admins (chatid, bot, message)
    nome = "amministratori"
    response = chat_admins(chatid, bot, message)
    titolo = title(message)
    messaggio = "Ciao " + b(nome(message)) + ": \n\n" +
                i("Hai chiesto la lista degli Amministratori!") + " \n" +
                b("Gruppo:") + " " + titolo + " \n\n"
    response.each do |admin|
    admin['user'] == nil ? user = admin['id'] : user = "@"+admin['user']
    msg =   "N: "+ b(admin['nome']) + "\n" +
            "U: "+ user + "\n" +
            "S: "+ b(admin['status']) + "\n" +
            "\n"
    messaggio = messaggio + msg
    end
    messaggio
end


def check_admin (bot, message)
    res = false
    response = bot.api.get_chat_member(chat_id: chatid(message), user_id: id(message))
        sts = response['result']['status']
    case sts
    when "creator"
        res = "Proprietario"
        print res
    when "administrator"
        res = "Amministratore"
        print res
    else
        print "Utente"
    end
    puts
    return res
end

def is_admin? (userid, bot, message)
    res = false
    rsp = bot.api.get_chat_member(chat_id: chatid(message), user_id: userid)
    sts = rsp['result']['status']
   (sts == "creator" or sts == "administrator") ? res = true : res = false
    res
end


# MAIN
# ************* CICLO PRINCIPALE DEL BOT ***************************************

Telegram::Bot::Client.run(token, logger: logger) do |bot|
    bot.listen do |message|
    
        messaggio = ""
        
        if message.text == '/motd'
          messaggio = `fortune`
          puts messaggio
          msg(chatid(message), messaggio, bot)
        end

        if message.text == '/regolamento@ISG_Ben_Bot'
          messaggio = regolamento(message)
          puts messaggio
            msg(chatid(message), messaggio, bot)
        end

        # test nuove funz
        if message.text == '/test'
            userid = message.from.id
            print "CHAT: ", title(message), " ID: ",chatid(message)," \n"
            #msg(chatid(message), messaggio, bot)
        end

        # Caso ADMINS
        if message.text == '/admin@ISG_Ben_Bot'
            if message.chat.type == "private"
                messaggio = "Questa è una chat privata!\n"
            else
            messaggio = lista_admins(chatid(message), bot, message)
            end
            msg(chatid(message), messaggio, bot)
        end

        # Caso KICK
        if  message.text == '/kick' or
            message.text == '/kik'
            kik = true
            error = false
            me = me(bot)

            chatid = message.chat.id
            reply = message.reply_to_message

            messaggio = ""
            saluto = ""
            n_utente = ""
            risposta = ""

            # Target User su cui è stato chiamato il kik
            if reply.nil?
                t_userkik = t_nomekik = t_idkik = nil
            else
                t_userkik = message.reply_to_message.from.username
                t_nomekik = message.reply_to_message.from.first_name
                t_idkik = message.reply_to_message.from.id.to_s

                t_userkik == nil ? t_reply = "Id: "+t_idkik : t_reply = "User: @"+t_userkik
            end

            # Caller User che ha chiamato il kik
            c_userkik = message.from.username
            c_nomekik = message.from.first_name
            c_idkik = message.from.id.to_s
            c_userkik == nil ? c_reply = "Id: "+c_idkik : c_reply = "User: @"+c_userkik

            if  kik and
                !is_admin?(c_idkik, bot, message)
                error = 1 # Non è amministratore
                if  !t_idkik.nil? and
                    is_admin?(t_idkik, bot, message)
                    error += 1 ## 2 E voleva kikkare un admin...
                end

                kik = false
            end

            if kik and reply.nil?
                error = 3 # Errore Admin :: Operazione sbagliata
                kik = false
            end

            if kik and t_idkik == me
                error = 4 # Errore Admin :: Vuole kikkare il bot
                kik = false
            end

            if kik and t_idkik == c_idkik
                error = 5 # Errore Admin :: Vuole kikkare se stesso
                kik = false
            end

            if kik and is_admin?(t_idkik, bot, message)
                error = 6 # Errore Admin :: Vuole kikkare altro Admin
                kik = false
            end

            saluto = "Ma che combini???\n"
            n_utente = "Utente: " + pulisci(c_nomekik) + "\n" + pulisci(c_reply) + "\n"

            case error
            when 1
                saluto = "TU NON PUOI KIKKARE NESSUNO\n"
                n_utente = "Utente: " + pulisci(c_nomekik) + "\n" + pulisci(c_reply) + "\n"
                risposta = "Al massimo ti becchi un kik tu!\n"
            when 2
                saluto = "TU NON PUOI KIKKARE NESSUNO\n"
                n_utente = "Utente: " + pulisci(c_nomekik) + "\n" + pulisci(c_reply) + "\n"
                risposta = "E VUOI PURE KIKKARE UN ADMIN!\nSEI UN SACRILEGO!"
            when 3
                risposta = "COSI' NON KIKKI NESSUNO!\nIMBRANATO!\n"
            when 4
                risposta = "VUOI KIKKARE ME:IL BOT???\nSEI UNO SPROVVEDUTO!\n"
            when 5
                risposta = "VUOI KIKKARE TE STESSO???\nCHIAMATE LA NEURO!\n"
            when 6
                risposta = "VUOI KIKKARE UN ALTRO ADMIN???\nSEI UN SOCIOPATICO!\n"
            else
                saluto = "Ciao, \n"
                n_utente = "Utente: " + pulisci(t_nomekik) + "\n" + pulisci(t_reply) + "\n"
                risposta = "E' Giunto il momento di lasciare in pace questo gruppo!"
            end
            
            messaggio = saluto + n_utente + risposta
            puts messaggio
            msg(chatid, messaggio, bot)

            if kik
                kick(chatid, t_idkik, bot)
            end
        end

        # Caso identità
        if message.text == '/whoami@ISG_Ben_Bot'

            tipo = check_admin(bot, message)
            pref = "un "
            case tipo
                when "Proprietario"
                    pref = "il "
                when "Amministratore"
                else
                    tipo = "Membro"
            end

            messaggio = "Ciao: " + b(nome(message)) + " \n" +
                        "hai chiesto di ricevere informazioni sul tuo account: \n" +
                        "sei " + pref + b(tipo) + "\n" +
                        "del gruppo: " + b(title (message)) + "\n" +
                        "il tuo id: " + b(id(message)) + "\n" +
                        "il tuo username: " +b(user(message))

            msg(chatid(message), messaggio, bot)
        end

        # Caso BENVENUTO
        if message.new_chat_members

            nomefunc = "new_chat_member"
            chatid = message.chat.id
            membri = message.new_chat_members

            membri.each do |utente|
                _id = utente.id
                _user = utente.username
                _nome = pulisci(utente.first_name)
                _titolo = title(message)

                messaggio = "Salve: " + _nome + "\n" +
                            "Benvenuto su: " + _titolo + "\n" +
                            "Prenditi un minuto per leggere il /regolamento \n" +
                            "Divertiti e buona permanenza!"

                msg(chatid, messaggio, bot)
                s_log(nomefunc, message.chat.id, bot, message, messaggio)
            end
        end
    end
end
