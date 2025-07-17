
// Persistable entity in db
interface Entity {
    id: number;
    name: string;
    description?: string;
    createdAt: Date;
    updatedAt: Date;
    isActive: boolean;

}

interface Campaign extends Entity {
    inception: Date;
    endDate?: Date;
    players: Player[];
    characters: Character[];
    setting: Setting;
    prompt: CampaignPrompt;
    parts: Part[];
    npcs: NPC[];
    currentLevel: number;
    items: MagicItem[];
    status: 'planning' | 'active' | 'hiatus' | 'completed';
}

interface CampaignPrompt extends Entity {
  description?: string;
  
  // Core Tone & Atmosphere
  tone: 'heroic' | 'gritty' | 'dark' | 'lighthearted' | 'epic' | 'horror' | 'comedic' | 'mysterious' | 'romantic' | 'political';
  mood: 'hopeful' | 'grim' | 'whimsical' | 'tense' | 'melancholic' | 'triumphant' | 'foreboding' | 'nostalgic';
  maturityLevel: 'family-friendly' | 'teen' | 'mature' | 'adult';
  
  // Thematic Elements
  primaryThemes: string[]; // e.g., ['redemption', 'sacrifice', 'power corruption', 'coming of age']
  conflictTypes: ('personal' | 'political' | 'cosmic' | 'moral' | 'survival' | 'mystery')[];
  
  // Setting Flavor
  settingGenre: 'high-fantasy' | 'low-fantasy' | 'dark-fantasy' | 'urban-fantasy' | 'steampunk' | 'gothic' | 'mythic' | 'post-apocalyptic';
  magicPrevalence: 'rare' | 'uncommon' | 'common' | 'ubiquitous';
  technologyLevel: 'primitive' | 'medieval' | 'renaissance' | 'industrial' | 'modern' | 'futuristic';
  
  // Narrative Style
  pacing: 'slow-burn' | 'steady' | 'fast-paced' | 'episodic' | 'milestone-driven';
  complexity: 'straightforward' | 'layered' | 'intricate' | 'labyrinthine';
  playerAgency: 'high' | 'medium' | 'guided' | 'on-rails';
  
  // Content Guidelines
  violenceLevel: 'minimal' | 'moderate' | 'realistic' | 'graphic';
  socialComplexity: 'simple' | 'moderate' | 'intricate' | 'byzantine';
  moralAmbiguity: 'clear' | 'nuanced' | 'gray' | 'subversive';
  
  // Inspiration & Reference
  inspirationSources?: string[]; // books, movies, games, etc.
  keyWords: string[]; // adjectives that capture the feel
  avoidanceList?: string[]; // themes/content to avoid
  
  // System Integration
  rulesEmphasis: 'strict' | 'flexible' | 'narrative-first' | 'rule-of-cool';
  homebrewFriendly: boolean;
}

interface Setting extends Entity {
    world: World;
    worldId: number;
    era: string;
    calendar?: Calendar;
    mainLocations: Location[];
    factions: Faction[];
    religions: Religion[];
    cosmology?: Cosmology;
    history: HistoricalEvent[];
    currentEvents: CurrentEvent[];
}

interface World extends Entity {
    type: 'planet' | 'plane' | 'realm' | 'dimension' | 'other';
    geography: string;
    climate: string;
    races: string[];
    technology: string;
    magic: string;
}


interface Calendar {
    id: number;
    name: string;
    months: Month[];
    daysPerWeek: number;
    currentDate: string;
    holidays: Holiday[];
    moonPhases?: string[];
}

interface Month {
    id: number;
    name: string;
    daysCount: number;
    season: string;
}

interface Holiday {
    id: number;
    name: string;
    date: string;
    description: string;
    importance: 'minor' | 'major' | 'critical';
}


interface HistoricalEvent extends Entity {
    date: string;
    significance: 'minor' | 'major' | 'world-changing';
    participants: string[];
    consequences: string[];
}

interface CurrentEvent extends Entity {
    locations: Location[];
    factions: Faction[];
    npcs: NPC[];
    importance: 'background' | 'minor' | 'major' | 'critical';
    status: 'brewing' | 'ongoing' | 'resolving' | 'aftermath';
}


interface Cosmology {
    id: number;
    planes: Plane[];
    connections: PlaneConnection[];
    deities: Deity[];
}

interface Plane {
    id: number;
    name: string;
    description: string;
    inhabitants: string[];
    traits: string[];
    accessPoints?: string[];
}

interface PlaneConnection {
    id: number;
    sourcePlane: Plane;
    sourcePlaneId: number;
    targetPlane: Plane;
    targetPlaneId: number;
    type: 'portal' | 'overlap' | 'ritual' | 'natural' | 'other';
    stability: 'permanent' | 'stable' | 'fluctuating' | 'temporary';
    description?: string;
}

interface Deity extends Entity {
    domains: string[];
    alignment: string;
    description: string;
    worshippers: string[];
    symbols: string[];
    clergy?: string;
}

interface Player extends Entity {
    characters: Character[];
}

interface SessionAttendance {
    id: number;
    session: Session;
    sessionId: number;
    player: Player;
    playerId: number;
    note?: string;
}

interface Character extends Entity {
    player: Player;
    playerId: number;
    campaign: Campaign;
    campaignId: number;
    race: string;
    class: string;
    level: number;
    background: string;
    alignment: string;
    abilities: Abilities;
    experience: number;
    personality: {
        traits?: string[];
        ideals?: string[];
        bonds?: string[];
        flaws?: string[];
    };
    inventory: Item[];
    features: string;
    backstory?: string;
    allies?: NPC[];
    enemies?: NPC[];
    notes?: string[];
    status: 'active' | 'inactive' | 'deceased';
}

interface Abilities {
    strength: number;
    dexterity: number;
    constitution: number;
    intelligence: number;
    wisdom: number;
    charisma: number;
}

interface Item {
    id: number;
    name: string;
    description?: string;
    quantity: number;
    weight?: number;
    value?: number;
    type: 'weapon' | 'armor' | 'gear' | 'consumable' | 'treasure' | 'other';
}

interface MagicItem extends Item {
    rarity: 'common' | 'uncommon' | 'rare' | 'very rare' | 'legendary' | 'artifact';
    attunement: boolean;
    attunedBy?: Character;
    charges?: {
        max: number;
        current: number;
        recharge?: string;
    };
    effects: string[];
}


interface Location extends Entity {
    parent?: Location;
    parentId?: number;
    children: Location[];
    type: 'continent' | 'region' | 'city' | 'town' | 'village' | 'dungeon' | 'wilderness' | 'building' | 'other';
    government?: string;
    population?: number;
    races?: string[];
    economy?: string;
    defenses?: string;
    keyNPCs?: NPC[];
    pointsOfInterest?: PointOfInterest[];
    rumors?: string[];
    secrets?: string[];
    climate?: string;
    terrain?: string;
    history?: string;
}


interface PointOfInterest extends Entity {
    location: Location;
    locationId: number;
    type: 'shop' | 'tavern' | 'temple' | 'guild' | 'landmark' | 'dungeon' | 'other';
    owner?: NPC;
    ownerId?: number;
    services?: string[];
    items?: Item[];
    hooks?: string[];
}


interface Faction extends Entity {
    leader?: NPC;
    leaderId?: number;
    members: NPC[];
    locations: Location[];
    goals: string[];
    methods: string[];
    resources: string[];
    allies: Faction[];
    enemies: Faction[];
    status: 'growing' | 'stable' | 'declining' | 'hidden' | 'defunct';
    playerRelationship: 'allied' | 'friendly' | 'neutral' | 'unfriendly' | 'hostile' | 'unknown';
    insignia?: string;
    hierarchy?: string;
}


interface Religion extends Entity {
    deities: Deity[];
    practices: string[];
    holySymbols: string[];
    temples: Location[];
    clergy: NPC[];
    holidays: Holiday[];
    tenets: string[];
    restrictions: string[];
}

interface Part extends Entity {
    campaign: Campaign;
    campaignId: number;
    summary: string;
    status: 'planned' | 'active' | 'completed' | 'abandoned';
    sessions: Session[];
    mainNPCs: NPC[];
    keyLocations: Location[];
    plotTwists?: string[];
    climax?: string;
    resolution?: string;
    nextPart?: Part;
    nextPartId?: number;
    previousPart?: Part;
    previousPartId?: number;
    order: number;
}

interface Session extends Entity {
    part: Part;
    partId: number;
    number: number;
    date?: Date;
    duration?: number; // In hours
    plan?: SessionPlan;
    summary?: SessionSummary;
    locations: Location[];
    npcs: NPC[];
    discoveries?: string[];
    nextSession?: Session;
    nextSessionId?: number;
}

interface Encounter extends Entity {
    description: string
}

interface Event extends Entity {
    description: string
}

interface SessionPlan extends Entity {
    session: Session;
    sessionId: number;
    goals: string[];
    openingScene?: string;
    encounters: Encounter[];
    events: Event[];
    keyNPCs: NPC[];
    locations: Location[];
    contingencies?: string[];
    secrets?: string[];
}

interface SessionSummary extends Entity {
    session: Session;
    sessionId: number;
    date: Date;
    attendees: Player[];
    narrative: string;
    highlights: string[];
    loot?: Item[];
    nextSessionHooks?: string[];
    attendance: SessionAttendance[];
    rewards?: {
        type: 'gold' | 'item' | 'experience' | 'favor' | 'information' | 'other';
        description: string;
        value?: number;
        item?: MagicItem;
        itemId?: number;
    }[];
}

interface NPC extends Entity {
    type: 'individual' | 'group';
    race?: string;
    class?: string;
    occupation: string;
    appearance: string;
    personality: string;
    abilities?: Abilities;
    motivation: string;
    goals?: string[];
    secrets?: string[];
    relationships: NPCRelationship[];
    location?: Location;
    locationId?: number;
    faction?: Faction;
    factionId?: number;
    status: 'alive' | 'deceased' | 'unknown';
    importance: 'background' | 'minor' | 'major' | 'villain' | 'ally';
    firstAppearance?: Session;
    firstAppearanceId?: number;
    voice?: string;
    mannerisms?: string[];
    inventory?: Item[];
    quotes?: string[];
    isUnique: boolean;
}

interface NPCRelationship {
    id: number;
    source: NPC;
    sourceId: number;
    target: NPC | Character;
    targetId: number;
    targetType: 'npc' | 'character';
    type: 'ally' | 'enemy' | 'family' | 'romantic' | 'professional' | 'other';
    description: string;
    intensity: 'weak' | 'moderate' | 'strong';
    isPublic: boolean;
}