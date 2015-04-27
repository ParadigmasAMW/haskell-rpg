import Control.Monad
import Control.Concurrent (threadDelay)
import Graphics.UI.Threepenny.Core
import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import qualified Graphics.UI.Threepenny as UI

import Paths
import BinaryTree

data ArvBin elemento = Nulo
    |Node elemento (ArvBin elemento)(ArvBin elemento)
    deriving (Show, Eq)

historyTree = Node "<b>Bem vindo a Batalha !</b><br> Voce estah frente a frente com um Orc maligno que deseja destruir a Vila dos programadores, infelizmente voce soh tem duas escolhas:<br><b>1 - Lutar bravamente</b> <br><b>2 - Lutar como um covarde</b>\r" (Node "Depois de muito de tempo de batalha voce percebe que anos de digitacao nao o tornaram o melhor guerreiro do reino, suas opcoes estao acabando assim como sua energia, felizmente seu raciocinio forjado em noites sem dormir lhe apresentam duas saidas<br><b>1 - Instanciar o espirito do maior guerreiro que ja existiu</b> <br><b>2 - Buscar ajuda de mais um bravo guerreiro</b>\r" (Node "Com as novas habilidades do guerreiro voce consegue levar a batalha para o seu lado, com poderes que voce nunca havia experimentado, enfrentando o seu poder o Orc decide usar suas habilidades mais poderosas de batalha o que novamente empata o embate, qual sua nova medida?<br><b>1 - Dar Implements no poder do Mago mais poderoso que ja existiu</b><br><b>2 - Tentar a sorte com buscas desesperadas com o Grande Sabio StackOverFlow</b>\r" (Node "Agora como um super guerreiro voce nao apenas tem for\231a e destreza inigualaveis como tambem tem a grande inteligencia e magias de um mago imparavel, nao ha nada que seu inimigo possa fazer perante sua forca, escolha como acabara com a raca do Orc inimigo: <br><b>1 - Use a Magia Singleton para acabar de vez com seu inimigo</b> <br><b>2 - Voce decide por deixar o Orc ir embora, pois julga que nao precisa tirar-lhe a vida</b>\r" (Node "Com apenas um ataque o Orc eh derrotado, sumindo assim da face do Hello World. <b>Parabens bravo guerreiro!</b> Voce sempre sera lembrado como grande heroi que salvou a Vila dos programadores do terrivel Orc do Plano de Custos.\r" Nulo Nulo) (Node "Atitude nobre e pacifica! Admirado por sua benovolencia, o Orc, apreciador de bons drinks, te convida para dividir uma guarrafa do melhor vinho das terras latinas brasileiras: CANCAO. E juntos voces compartilham SUCH A GREAT TIME!\r" Nulo Nulo)) (Node "Execelente! O primeiro link de sua busca o Grande Sabio lhe entrega poderes que voce nao faz ideia de como funciona, mas eh inexplicavelmente efetivo contra o Orc.<br><b>1 apenas use seu novo poder</b>\r" (Node "Seu poder funciona, mas vc nao sabe porque. O Orc do Plano de Custos eh derrotado e vc recebe uma grande recompensa dos habitantes da aldeia dos programadores: UMA ASSINATURA DO SUBLIME!\r" Nulo Nulo) (Node "Seu poder funciona, e voce acha que sabe o porque, mas na verdade nao eh isso que voce esta pensando jovem gafanhoto.\r" Nulo Nulo))) (Node "Em busca de um aliado voce encontra o bravo guerreiro barbado Simiao o Valente, que se une a voce em sua impiedosa batalha, porem por mais bravo e habilidoso que Simiao seja, suas habilidades como Game developer nao trazem a vitoria para seu lado, pensando friamente voces chegam a duas conclusoes<br><b>1 - Simiao arriscaria sua vida para destrair o Orc enquanto voce prepara o poderoso Abstract factory da morte *** ROLL A D6 ***</b> <br><b>2 - Frente as dificuldades de processamento voces decidem ir em buscar da ultima cartada, o machado sagrado do COBOL</b>\r" (Node "A distracao FUNFA, mas o seu MM em Desenho de Software nao foi o suficiente para deter o Orc do Plano de Custos. O que voce faz? <br><b>1 - Voce envia um e-mail para Deusa Milene</b> <br><b>2 - Chama seus amigos de gueto --> A GANGUE DOS QUATRO!</b>\r" (Node "Agraciado com o grande conhecimento da Deusa. Voce eh respondido em tempo real (ON THE FUCKING FLY) e com todos os detalhes necessarios, voce executa seu inimigo com perfeicao. SS Easy.\r" Nulo Nulo) (Node "Cabe\231as rolam e o inverno estah chegando! A Gangue dos Quatro traz os dragoes da Daenerys Targaryen, Filha da Tormenta, a Nao Queimada, Mae de Dragoes, Rainha de Mereen, Rainha dos Andalos e dos Primeiros Homens, Senhora dos Sete Reinos, Khaleesi dos Dothraki, a Primeira de Seu Nome. <mk_voice> WELL DONE! </mk_voice>\r" Nulo Nulo)) (Node "Simiao ficou para tras, mas voce finalmente encontrou o machado COBOL, com sua magia antiga e poderosa voce se sente capaz de muitas coisas\8230 qual sua decisao ?<br><b>1 - Voltar para ajudar seu caro amigo e salvar a Vila dos Programadores</b> <br><b>2 - Com todo o poder em maos voce decide abandonar simiao e usufruir de seus poderes em outro lugar</b>\r" (Node "Ao voltar para batalha e encontrar seu camarada derrotado e miguelando pelo chao, sua for\231a se amplifica, juntamente com as forcas do COBOL voce desfere o seu ataque secreto: Lamina da linguagem milenar o terrivel Orc nao consegue se defender e acaba derrota, aproveite a gloria de sua vitoria merecida !\r" Nulo Nulo) (Node "Com os poderes misticos do COBOL voce podera faturar muito em sistemas legado, porem sua Vila ficou para tras e a lembranca de seu amigo Simiao deixado para morrer sem motivo ainda ficarao em sua mente por um bom tempo, as vezes voce pode se arrepender de algumas coisas, ou nao.\r" Nulo Nulo)))) (Node "Lutando como um covarde, voce conseguiu se esconder do malvado orc e esta planejando seu proximo passo <br><b>1 - Atacar o orc por tras</b><br><b>2 - Pedir ajuda para o Luciano</b>\r" (Node "Voce conseguiu apunhalar o orc com sua faca de serra, ele sentiu seu golpe e est\225 atordoado, pense muito bem no que voce irah fazer, seu proximo passo pode definir sua curta vida!<br><b>1 - Use seu tempo para continuar atacando</b><br><b>2 - Ele estah enfraquecido, e hora de recuar e pensar em outra strategia</b>\r" (Node "Sua batalha se extende muito e voce chega a um impasse sem cafe ou energetico, nao consegue mais lutar. Sem energias apenas duas coisas aparecem em sua mente <br><b>1 - Girar o analogico para recuperar sua ki</b> <br><b>2 - Fugir para colina</b>\r" (Node "Mesmo sem voce ter percebido, seus colegas da Vila estavam com as maos levantadas para lhe auxiliar. Todo o ki acumulado eh lancado contra o Orc e voce se sai vitorioso, agora conhecido como kakaroto do HASKELL voce detem uma posicao privilegiada na Vila do Programadores, sentando ao lado do Mestre Hilmer no santuario do Lappis!\r" Nulo Nulo) (Node "Sua escapada acontece com sucesso, por sorte voce lutou tanto com o Orc que ele desistiu\r" Nulo Nulo)) (Node "Sua cautela nao foi muito bem planejada! O tempo que vc deu para o orc o fez se recuperar das feridas! CORRA JOVEM PADAWAN PROGRAMADOR, CORRA! O seu tempo esta acabando. O que voce fara?<br><b>1 - Tudo ou nada, pule no orc e acabe com a amea\231a no x1 das estrelas</b><br><b>2 - Nao vale a pena arriscar sua vida por um bando de programadores que so pensam no URI, fuja pela sua vida</b>\r" (Node "Como um covarde ate que voce luta bem para um programador. Depois de longos 5 minutos de batalha voce consegue vencer seu feroz adversario, que foge para a floresta promentendo vingan\231a e muitas provas de humanidades e cidadania todos os sabado das 10h as 18 horas, tome cuidado\8230 Coisas ruins acontecem.\r" Nulo Nulo) (Node "Voce descobre que o E-Judge do Mestre Jedi Edson Alves eh melhor que todos os juizes existes e com esse fato nas maos, sua fuga eh bem sucedida. Parabens, seu tolo!\r" Nulo Nulo))) (Node "Luciano \233 um cara muito tranquilo e pacifista, nao apoiaria a luta de nenhuma maneira, ele como dententor de grande sabedoria lhe dah dois conselhos.<br><b>1 - Jogue uma rede no orc e tente restringir seus movimentos, mas sem machuca-lo</b><br><b>2 - Sempre eh bom ter paz e evitar brigas, vah para casa e programe um software de padaria em java</b>\r" (Node "Voce prendeu o Orc em sua rede, sem o mestre Lu por perto para lhe dar palavras brandas de sabedoria voce pode exercitar sua bondade ou ate mesmo seu lado mais obscuro, qual eh sua escolha? <br><b>1 - Decepe a cabe\231a do orc e se proclame o novo heroi da Vila dos Programadores</b><br><b>2 - Chame Alvaro Jesus e pe\231a mais uma vez palavras de sabedoria</b>\r" (Node "Com a cabe\231a do orc em suas maos vc sente o gosto da vitoria, talvez ele nao seja tao doce quando se eh necessario cortar cabecas, mas a vida de seus colegas programadores esta a salvo, por enquanto ...\r" Nulo Nulo) (Node "Impresionante como uma pessoa que nao consegue fazer nada sozinha chegou ate aqui!!! As indicacoes do Mestre Alvaro Jesus eh aprisionar o Orc em uma cela, e assim voce o faz! Com a ameaca contida voce pode voltar a programar em PASQUAL tranquilamente.\r" Nulo Nulo)) (Node "Enquanto voce ganha alguns trocados com sua mais nova magia CRUDiana, o orc destroi a cidade \8230 Mas o que voc\234 tem a ver com isso ?<br><b>1 - O peso da sua decisao bate em sua consciencia e vc decide lutar</b><br><b>2 - Nao importa, o orc nunca ira te achar no seu quarto escuro, apenas continue!</b>\r" (Node "Infelizmente voce chegou tarde demais, o Orc acabou com tudo que valia a pena ser salvo, s\243 sobrou\r" Nulo Nulo) (Node "Que bela covardia, a sua ! voce sobreviveu a custa de muitos Printfs do futuro, nao existe mais a Vila dos Programadores e voce e o ultimo programador de CRUD da terra, temo pelo futuro da programacao." Nulo Nulo))))

play :: IO ()
play = do
    static <- getStaticDir
    startGUI defaultConfig { jsStatic = Just static } setup


setup :: Window -> UI ()
setup w = void $ do
    return w # set title "HaskellRPG"
    UI.addStyleSheet w "styles.css"

    getBody w #+
        [UI.div #. "wrap" #+ (greet)]

    gameLoop w historyTree

gameLoop w Nulo = do
    formRefresh <- UI.form # set (attr "action") "/"
    element formRefresh # set (attr "id") "formRefresh"

    (buttonRefresh, viewRefresh) <- mkButton "Jogar Novamente!"
    element buttonRefresh # set (attr "form") "formRefresh"

    getBody w #+
        [UI.div #. "wrap" #+ (map element [formRefresh, viewRefresh])]

gameLoop w (Node elemento esq dir) = do
    historyStep <- getHistory elemento

    (buttonLeft, viewLeft) <- mkButton buttonLeftTitle
    on UI.hover buttonLeft $ \_ -> do
        element buttonLeft # set text (rowDiceTitle)
    on UI.leave buttonLeft $ \_ -> do
        element buttonLeft # set text (buttonLeftTitle)
    on UI.click buttonLeft $ \_ -> do
        gameLoop w esq

    (buttonRight, viewRight) <- mkButton buttonRightTitle
    on UI.hover buttonRight $ \_ -> do
        element buttonRight # set text (rowDiceTitle)
    on UI.leave buttonRight $ \_ -> do
        element buttonRight # set text (buttonRightTitle)
    on UI.click buttonRight $ \_ -> do
        gameLoop w dir

    let buttons = [viewLeft, viewRight]

    getBody w #+
        [UI.div #. "wrap" #+ (map element (historyStep ++ buttons))]

    where rowDiceTitle = "Rolar dados!"
          buttonLeftTitle = "Escolher opção 1"
          buttonRightTitle = "Escolher opção 2"

getHistory historyStep = do
    list    <- UI.ul #. "buttons-list"
    element list    #+ [UI.div #. "history" # set html historyStep]
    return [list]

greet :: [UI Element]
greet =
    [ UI.h1  #+ [string "HaskellRPG!"]
    , UI.div #+ [string "Jogo de RPG baseado em escolhas contruido em Haskell."]
    ]

mkButton :: String -> UI (Element, Element)
mkButton title = do
    button <- UI.button #. "button" #+ [string title]
    view   <- UI.p #+ [element button]
    return (button, view)