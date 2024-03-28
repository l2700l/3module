npx truffle init

в конфиге разкомментируем сеть development и чиним порт (9545)

npx truffle create contract Owner

npx truffle create migration Owner

npx truffle create test Owner

с test копируем импорт в миграцию

через деплоер деплоим

пишем аудит и чинякаем контракт

пишем тесты, все однотипные

npx truffle develop в одном терминале

npx truffle test в другом терминале

в sh ->
npx truffle develop & npx truffle test

не забудь про чмудилу (chmod)