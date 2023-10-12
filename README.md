# matchmaker_lol
# Dominio
dominio ou modulos ou entidades -> Player; Room, Team, Match

Cada player deve ter seu nome  e lane selecionada, após selecionado, deve marcar como pronto;
Deve guardar o id do player e o nome e role nos cookies da pagina, para quando reiniciado a buscar os dados, caso não tenha, crie um novo.
Player{
	id;
	name;
	role;
	isReady;
}

Quando criada deve gerar um ID para que outros players possam acessar a  Room.
Quando todos os jogadores estão como isReady é realizado a separação dos teams {blue e red} -> Match.
Para o host deve aparecer o botão de kikar os players da sala.
Room{
	id;
	Set<Player> players;
	hostID;
}

Team{
	id;
	List<Player> players;
}
O lado dos times sera definido de forma aleatoria, assim como os membros de cada time.
O lado seria definido através da lista dos times onde  a primeira posição sera blue e a segunda será red.
Match{
	id;
	Room id;
	List<Team> teams;
}

----------------------------------------------------------------------------------------------------------------
# Definições arquiteturais
Consumo de Apis: Utilizar padrão repository 
Organização de camadas: Utilizando padrão de inversão de controle.
Gerenciamento de estado:  ValueNotifier com state pattern(https://refactoring.guru/pt-br/design-patterns/state) 
Para localStorege: Usar Services.
Para conversão de dados: Utilizar adapter.
Para copia de dados imutaveis: CopyWith/prototype
Para representação de regra de negocio: Entidade
Para execução de regra de negocio: Usecases

----------------------------------------------------------------------------------------------------------------
# Packages
UUID =https://pub.dev/packages/uuid Para criação de ID's unicos.
result_dart = https://pub.dev/packages/result_dart  Para organização de tuplas e programação funcional.
flutter_modular = https://pub.dev/packages/flutter_modular  Para rotas e inversão de controle.
firebase_core & firebase_storage = https://pub.dev/packages/firebase_core & https://pub.dev/packages/firebase_storage Para armazenamento de dados.
shared_preferences=  https://pub.dev/packages/shared_preferences  Para persistencia de dados local.
mocktail = https://pub.dev/packages/mocktail Para mockagem dos dados de teste.
