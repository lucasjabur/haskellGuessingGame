import System.Random
import System.IO (stdout, hGetContents, hSetBuffering, openFile, BufferMode(NoBuffering), IOMode(ReadWriteMode))
import System.Directory

arquivo_recorde :: Int -> IO()

arquivo_recorde tentativa = do 
   existe <- doesFileExist "highscore.txt"

   if existe == True then do novo_recorde tentativa
   else writeFile "highscore.txt" (show tentativa)


novo_recorde :: Int -> IO()

novo_recorde tentativa = do 
   arquivo <- openFile "highscore.txt" ReadWriteMode
   conteudo <- hGetContents arquivo

   if read(conteudo) > tentativa then writeFile "highscore.txt" (show tentativa)
   else return()


game :: Int -> Int -> IO()

game numRandom tentativa = do 
   putStrLn ("Tentativa: " ++ show(tentativa))
   putStr "Digite o seu palpite: "
   numero <- readLn :: IO Int

   if numero > numRandom then do
      putStrLn "O valor inserido eh maior que o numero correto!\n"
      game numRandom (tentativa + 1)

   else if numero < numRandom then do 
      putStrLn "O valor inserido eh menor que o numero correto!\n"
      game numRandom (tentativa + 1)

   else do
      putStrLn ("Parabens! Voce acertou em " ++ show(tentativa) ++ " tentativas!")
      arquivo_recorde tentativa


main :: IO()

main = do 
   hSetBuffering stdout NoBuffering
   numRandom <- randomRIO(1,100) :: IO Int
   putStrLn "Boas vindas ao Jogo da Adivinhação!\n"
   putStrLn "Estou pensando em um número entre 1 a 100. Tente adivinhá-lo!\n"
   game numRandom 1
   
   putStr "\nDeseja jogar novamente? (s para sim, qualquer outra coisa para sair): "
   saida <- getLine

   if saida /= "s" then putStrLn "Obrigado por ter jogado o Jogo da Adivinhacao!\n"
   else do main
