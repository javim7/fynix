/// Fynix mock data for frontend-only development.
/// Replace with real providers once backend is connected.
library;

// ─── User context ─────────────────────────────────────────────────────────────
const int kMockEmbers = 120;
const int kMockLeagueRank = 8;
const int kMockLeagueTotal = 30;
const String kMockLeagueName = 'Gold II';
const int kMockWeeklyXp = 1540;
const int kMockXpToPromotion = 120;
const int kMockXpThisLevel = 8450;
const int kMockXpNextLevel = 10000;
const int kMockDaysRemaining = 4;

// ─── League user ─────────────────────────────────────────────────────────────
class MockLeagueUser {
  const MockLeagueUser({
    required this.rank,
    required this.name,
    required this.username,
    required this.level,
    required this.weeklyXp,
    this.isCurrentUser = false,
  });

  final int rank;
  final String name;
  final String username;
  final int level;
  final int weeklyXp;
  final bool isCurrentUser;
}

// 30 athletes — top 6 = promotion, bottom 6 = demotion
const kMockLeagueAthletes = [
  MockLeagueUser(rank: 1,  name: 'María R.',   username: 'mariar',     level: 16, weeklyXp: 3180),
  MockLeagueUser(rank: 2,  name: 'Pedro A.',   username: 'pedroa',     level: 14, weeklyXp: 2840),
  MockLeagueUser(rank: 3,  name: 'Diego L.',   username: 'diegol',     level: 15, weeklyXp: 2620),
  MockLeagueUser(rank: 4,  name: 'Ana P.',     username: 'anap',       level: 13, weeklyXp: 2310),
  MockLeagueUser(rank: 5,  name: 'Luis C.',    username: 'luisc',      level: 14, weeklyXp: 2050),
  MockLeagueUser(rank: 6,  name: 'Sofía M.',   username: 'sofiam',     level: 12, weeklyXp: 1660),
  // ── Safe zone ─────────────────────────────────────────────────────────────
  MockLeagueUser(rank: 7,  name: 'Tomás H.',   username: 'tomash',     level: 11, weeklyXp: 1620),
  MockLeagueUser(rank: 8,  name: 'Javi',       username: 'javimombiela', level: 12, weeklyXp: 1540, isCurrentUser: true),
  MockLeagueUser(rank: 9,  name: 'Andrea V.',  username: 'andreav',    level: 11, weeklyXp: 1480),
  MockLeagueUser(rank: 10, name: 'Roberto G.', username: 'robertog',   level: 10, weeklyXp: 1410),
  MockLeagueUser(rank: 11, name: 'Carmen B.',  username: 'carmenb',    level: 10, weeklyXp: 1320),
  MockLeagueUser(rank: 12, name: 'Felipe O.',  username: 'felipeo',    level: 9,  weeklyXp: 1260),
  MockLeagueUser(rank: 13, name: 'Valentina S.', username: 'vals',     level: 10, weeklyXp: 1180),
  MockLeagueUser(rank: 14, name: 'Marcos N.',  username: 'marcosn',    level: 9,  weeklyXp: 1090),
  MockLeagueUser(rank: 15, name: 'Lucía F.',   username: 'luciaf',     level: 8,  weeklyXp: 1010),
  MockLeagueUser(rank: 16, name: 'Alejandro P.', username: 'alep',     level: 9,  weeklyXp: 960),
  MockLeagueUser(rank: 17, name: 'Daniela Q.', username: 'danielaq',   level: 8,  weeklyXp: 900),
  MockLeagueUser(rank: 18, name: 'Sergio L.',  username: 'sergiol',    level: 8,  weeklyXp: 850),
  MockLeagueUser(rank: 19, name: 'Natalia R.', username: 'nataliar',   level: 7,  weeklyXp: 800),
  MockLeagueUser(rank: 20, name: 'Julián M.',  username: 'julianm',    level: 7,  weeklyXp: 750),
  MockLeagueUser(rank: 21, name: 'Isabella T.', username: 'isabellaT', level: 7,  weeklyXp: 700),
  MockLeagueUser(rank: 22, name: 'Rodrigo B.', username: 'rodrigob',   level: 6,  weeklyXp: 740),
  MockLeagueUser(rank: 23, name: 'Paola G.',   username: 'paolag',     level: 6,  weeklyXp: 710),
  MockLeagueUser(rank: 24, name: 'Emilio V.',  username: 'emiliov',    level: 6,  weeklyXp: 680),
  // ── Demotion zone ─────────────────────────────────────────────────────────
  MockLeagueUser(rank: 25, name: 'Pablo M.',   username: 'pablom',     level: 5,  weeklyXp: 620),
  MockLeagueUser(rank: 26, name: 'Elena S.',   username: 'elenas',     level: 5,  weeklyXp: 540),
  MockLeagueUser(rank: 27, name: 'Raúl F.',    username: 'raulf',      level: 4,  weeklyXp: 450),
  MockLeagueUser(rank: 28, name: 'Isabel R.',  username: 'isabelr',    level: 4,  weeklyXp: 380),
  MockLeagueUser(rank: 29, name: 'David C.',   username: 'davidc',     level: 3,  weeklyXp: 290),
  MockLeagueUser(rank: 30, name: 'Natalia B.', username: 'nataliab',   level: 2,  weeklyXp: 180),
];

// ─── League clubs ────────────────────────────────────────────────────────────
class MockLeagueClub {
  const MockLeagueClub({
    required this.rank,
    required this.name,
    required this.sport,
    required this.members,
    required this.weeklyXp,
    this.isCurrentUserClub = false,
  });

  final int rank;
  final String name;
  final String sport;
  final int members;
  final int weeklyXp;
  final bool isCurrentUserClub;
}

const kMockLeagueClubs = [
  MockLeagueClub(rank: 1, name: 'Runners LATAM',  sport: 'Running',   members: 1248, weeklyXp: 48200),
  MockLeagueClub(rank: 2, name: 'Ciclismo MX',    sport: 'Ciclismo',  members: 632,  weeklyXp: 31500),
  MockLeagueClub(rank: 3, name: 'Triatletas Pro',  sport: 'Triatlón',  members: 314,  weeklyXp: 28400, isCurrentUserClub: true),
  MockLeagueClub(rank: 4, name: 'Fuerza & Vida',  sport: 'Fuerza',    members: 891,  weeklyXp: 22100),
  MockLeagueClub(rank: 5, name: 'Trail & Montaña', sport: 'Trail',    members: 427,  weeklyXp: 18900),
];

// ─── Mock challenges ─────────────────────────────────────────────────────────
class MockChallenge {
  const MockChallenge({
    required this.title,
    required this.description,
    required this.progressValue,
    required this.targetValue,
    required this.targetUnit,
    required this.xpReward,
    required this.emberReward,
    this.isPremium = false,
    this.isCompleted = false,
  });

  final String title;
  final String description;
  final double progressValue;
  final double targetValue;
  final String targetUnit;
  final int xpReward;
  final int emberReward;
  final bool isPremium;
  final bool isCompleted;
}

const kMockChallenges = [
  MockChallenge(
    title: 'Corre 10 km esta semana',
    description: 'Acumula 10 kilómetros corriendo antes del domingo',
    progressValue: 7.2,
    targetValue: 10.0,
    targetUnit: 'km',
    xpReward: 150,
    emberReward: 30,
  ),
  MockChallenge(
    title: 'Completa 3 entrenamientos',
    description: '3 sesiones de cualquier deporte esta semana',
    progressValue: 2,
    targetValue: 3,
    targetUnit: 'sesiones',
    xpReward: 100,
    emberReward: 20,
  ),
  MockChallenge(
    title: 'Entrena 5 días seguidos',
    description: 'Mantén tu racha activa 5 días consecutivos',
    progressValue: 3,
    targetValue: 5,
    targetUnit: 'días',
    xpReward: 200,
    emberReward: 50,
  ),
  MockChallenge(
    title: '¡Ya completaste este!',
    description: 'Corre 5 km en una sola sesión',
    progressValue: 5,
    targetValue: 5,
    targetUnit: 'km',
    xpReward: 80,
    emberReward: 15,
    isCompleted: true,
  ),
  MockChallenge(
    title: 'Velocista Pro',
    description: 'Completa un kilómetro en menos de 5:00 min/km',
    progressValue: 0,
    targetValue: 1,
    targetUnit: 'km',
    xpReward: 300,
    emberReward: 80,
    isPremium: true,
  ),
];

// ─── Mock events ─────────────────────────────────────────────────────────────
class MockEvent {
  const MockEvent({
    required this.title,
    required this.description,
    required this.type,
    required this.reward,
    required this.endsInDays,
    this.progressValue = 0,
    this.targetValue = 0,
    this.targetUnit = '',
    this.participants = 0,
    this.isFeatured = false,
    this.isCompleted = false,
    // Race-specific
    this.isRace = false,
    this.raceDate = '',
    this.location = '',
    this.distance = '',
    this.registrationFee = '',
    // Community-specific
    this.cause = '',
    this.causeImpact = '',
  });

  final String title;
  final String description;
  final String type; // 'race', 'community'
  final String reward;
  final int endsInDays;
  final double progressValue;
  final double targetValue;
  final String targetUnit;
  final int participants;
  final bool isFeatured;
  final bool isCompleted;
  // Race fields
  final bool isRace;
  final String raceDate;
  final String location;
  final String distance;
  final String registrationFee;
  // Community fields
  final String cause;
  final String causeImpact; // e.g. '1 km = 1 comida donada'
}

const kMockEvents = [
  // ── Featured races ────────────────────────────────────────────────────────
  MockEvent(
    title: '21K De la Ciudad de Guatemala',
    description: 'El medio maratón más esperado del año. Recorre las calles históricas de la ciudad y cruza la meta en el Parque Central.',
    type: 'race',
    reward: '800 XP + Insignia Finisher',
    endsInDays: 18,
    participants: 3200,
    isFeatured: true,
    isRace: true,
    raceDate: '27 Abr 2026',
    location: 'Ciudad de Guatemala',
    distance: '21.1 km',
    registrationFee: 'Q150',
  ),
  MockEvent(
    title: 'Maratón de la Ciudad',
    description: 'La carrera insignia de Guatemala. 42K por las zonas más emblemáticas. Para corredores que buscan su mejor marca personal.',
    type: 'race',
    reward: '1500 XP + Insignia Maratonista',
    endsInDays: 46,
    participants: 1850,
    isFeatured: true,
    isRace: true,
    raceDate: '24 May 2026',
    location: 'Ciudad de Guatemala',
    distance: '42.2 km',
    registrationFee: 'Q250',
  ),

  // ── Community events ──────────────────────────────────────────────────────
  MockEvent(
    title: 'Corre 10K contra el Hambre',
    description: 'Por cada kilómetro que corras esta semana, Fynix dona una comida a familias en situación vulnerable. ¡Tus pasos importan!',
    type: 'community',
    reward: '300 XP + Insignia Solidaria',
    endsInDays: 6,
    progressValue: 6842,
    targetValue: 10000,
    targetUnit: 'km',
    participants: 4127,
    cause: 'Banco de Alimentos Guatemala',
    causeImpact: '1 km = 1 comida donada',
  ),
  MockEvent(
    title: 'Pedalea por el Planeta',
    description: 'Juntos podemos compensar toneladas de CO₂. Cada kilómetro en bicicleta cuenta como una acción climática real.',
    type: 'community',
    reward: '250 XP + Insignia Verde',
    endsInDays: 14,
    progressValue: 48200,
    targetValue: 100000,
    targetUnit: 'km',
    participants: 2890,
    cause: 'Reforestamos Guatemala',
    causeImpact: '50 km = 1 árbol plantado',
  ),
  MockEvent(
    title: 'Kilómetros por la Educación',
    description: 'Cada 5 km que completes ayuda a costear materiales escolares para niños en comunidades rurales de Guatemala.',
    type: 'community',
    reward: '200 XP + Badge Educador',
    endsInDays: 21,
    progressValue: 3150,
    targetValue: 5000,
    targetUnit: 'km',
    participants: 1340,
    cause: 'Fundación Ayúdame a Crecer',
    causeImpact: '5 km = kit escolar donado',
  ),
];

// ─── Mock recent activities ───────────────────────────────────────────────────
class MockActivity {
  const MockActivity({
    required this.name,
    required this.distanceKm,
    required this.xpEarned,
    required this.sport,
    required this.durationMin,
    required this.daysAgo,
  });

  final String name;
  final double distanceKm;
  final int xpEarned;
  final String sport; // icon key
  final int durationMin;
  final int daysAgo;
}

const kMockActivities = [
  MockActivity(
    name: 'Carrera matutina',
    distanceKm: 8.2,
    xpEarned: 82,
    sport: 'running',
    durationMin: 46,
    daysAgo: 0,
  ),
  MockActivity(
    name: 'Rodada urbana',
    distanceKm: 25.0,
    xpEarned: 100,
    sport: 'cycling',
    durationMin: 72,
    daysAgo: 1,
  ),
];

// ─── Mock friend activities (for Home "En tu red" section) ───────────────────
class MockFriendActivity {
  const MockFriendActivity({
    required this.name,
    required this.username,
    required this.sport,
    required this.distanceKm,
    required this.durationMin,
    required this.xpEarned,
    required this.daysAgo,
    required this.likeCount,
    required this.commentCount,
  });

  final String name;
  final String username;
  final String sport; // 'running' | 'cycling' | 'strength' | 'swimming'
  final double distanceKm;
  final int durationMin;
  final int xpEarned;
  final int daysAgo;
  final int likeCount;
  final int commentCount;
}

const kMockFriendActivities = [
  MockFriendActivity(
    name: 'María R.',
    username: 'mariar',
    sport: 'running',
    distanceKm: 12.4,
    durationMin: 65,
    xpEarned: 124,
    daysAgo: 0,
    likeCount: 14,
    commentCount: 3,
  ),
  MockFriendActivity(
    name: 'Pedro A.',
    username: 'pedroa',
    sport: 'cycling',
    distanceKm: 40.0,
    durationMin: 90,
    xpEarned: 160,
    daysAgo: 0,
    likeCount: 27,
    commentCount: 5,
  ),
  MockFriendActivity(
    name: 'Diego L.',
    username: 'diegol',
    sport: 'running',
    distanceKm: 5.0,
    durationMin: 28,
    xpEarned: 50,
    daysAgo: 1,
    likeCount: 8,
    commentCount: 1,
  ),
  MockFriendActivity(
    name: 'Ana P.',
    username: 'anap',
    sport: 'strength',
    distanceKm: 0,
    durationMin: 45,
    xpEarned: 45,
    daysAgo: 1,
    likeCount: 11,
    commentCount: 2,
  ),
];

// ─── Store items ─────────────────────────────────────────────────────────────
class MockStoreItem {
  const MockStoreItem({
    required this.name,
    required this.description,
    required this.emberCost,
    required this.icon,
    required this.category,
    this.isOwned = false,
  });

  final String name;
  final String description;
  final int emberCost;
  final String icon; // emoji fallback for quick mock
  final String category; // 'boost', 'avatar', 'title'
  final bool isOwned;
}

const kMockStoreItems = [
  // Boosts
  MockStoreItem(name: 'Congelador de Racha', description: 'Protege tu racha un día sin entrenar', emberCost: 50, icon: '🛡️', category: 'boost'),
  MockStoreItem(name: 'XP Doble', description: '+100% XP en tu próximo entrenamiento', emberCost: 80, icon: '⚡', category: 'boost'),
  MockStoreItem(name: 'XP Extra 3x', description: 'Triple XP durante 24 horas', emberCost: 150, icon: '🔥', category: 'boost'),
  // Avatar
  MockStoreItem(name: 'Marco Dorado', description: 'Marco especial para tu avatar', emberCost: 30, icon: '✨', category: 'avatar'),
  MockStoreItem(name: 'Aura Flamante', description: 'Efecto de llamas en tu avatar', emberCost: 60, icon: '🌟', category: 'avatar'),
  MockStoreItem(name: 'Corona de Liga', description: 'Accesorio exclusivo de temporada', emberCost: 120, icon: '👑', category: 'avatar', isOwned: true),
  // Titles
  MockStoreItem(name: '"El Madrugador"', description: 'Entrena 20 veces antes de las 7 AM', emberCost: 100, icon: '🌅', category: 'title'),
  MockStoreItem(name: '"Bestia del Asfalto"', description: 'Corre 500 km totales', emberCost: 150, icon: '💨', category: 'title'),
  MockStoreItem(name: '"Leyenda de Liga"', description: 'Alcanza la Liga Diamante', emberCost: 300, icon: '💎', category: 'title'),
];

// ─── Ember IAP packages ───────────────────────────────────────────────────────
class MockEmberPackage {
  const MockEmberPackage({
    required this.embers,
    required this.price,
    required this.priceUsd,
    this.isPopular = false,
    this.isBestValue = false,
  });

  final int embers;
  final String price; // display string e.g. '$3.99'
  final double priceUsd;
  final bool isPopular;
  final bool isBestValue;
}

const kMockEmberPackages = [
  MockEmberPackage(embers: 100,  price: r'$0.99',  priceUsd: 0.99),
  MockEmberPackage(embers: 500,  price: r'$3.99',  priceUsd: 3.99,  isPopular: true),
  MockEmberPackage(embers: 1200, price: r'$7.99',  priceUsd: 7.99),
  MockEmberPackage(embers: 3000, price: r'$15.99', priceUsd: 15.99, isBestValue: true),
];
