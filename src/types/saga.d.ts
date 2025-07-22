
// Persistable entity in db
export interface PersistableEntity {
    id: number;
    name: string;
    description?: string;
    createdAt: Date;
    updatedAt: Date;
}

export interface Campaign extends PersistableEntity {
    inception: Date;
    endDate?: Date;
    players: Player[];
    characters: Character[];
    setting: Setting;
    prompt: CampaignPrompt;
    parts: Part[];
    npcs: NPC[];
    currentLevel: number;
    magicItems: MagicItem[];
    status: 'planning' | 'active' | 'hiatus' | 'completed';
}

export interface CampaignPrompt extends PersistableEntity {
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
  
  homebrewFriendly: boolean;
}

export interface Setting extends PersistableEntity {
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

export interface World extends PersistableEntity {
    type: 'planet' | 'plane' | 'realm' | 'dimension' | 'other';
    geography: string;
    climate: string;
    races: string[];
    technology: string;
    magic: string;
}


export interface Calendar extends PersistableEntity {
    months: Month[];
    daysPerWeek: number;
    currentDate: string;
    holidays: Holiday[];
    moonPhases?: string[];
}

export interface Month extends PersistableEntity {
    daysCount: number;
    season: string;
}

export interface Holiday extends PersistableEntity {
    date: string;
    description: string;
    importance: 'minor' | 'major' | 'critical';
}


export interface HistoricalEvent extends PersistableEntity {
    date: string;
    significance: 'minor' | 'major' | 'world-changing';
    participants: string[];
    consequences: string[];
}

export interface CurrentEvent extends PersistableEntity {
    locations: Location[];
    factions: Faction[];
    npcs: NPC[];
    importance: 'background' | 'minor' | 'major' | 'critical';
    status: 'brewing' | 'ongoing' | 'resolving' | 'aftermath';
}


export interface Cosmology extends PersistableEntity {
    planes: Plane[];
    connections: PlaneConnection[];
    deities: Deity[];
}

export interface Plane extends PersistableEntity {
    description: string;
    inhabitants: string[];
    traits: string[];
    accessPoints?: string[];
}

export interface PlaneConnection extends PersistableEntity {
    sourcePlane: Plane;
    sourcePlaneId: number;
    targetPlane: Plane;
    targetPlaneId: number;
    type: 'portal' | 'overlap' | 'ritual' | 'natural' | 'other';
    stability: 'permanent' | 'stable' | 'fluctuating' | 'temporary';
    description?: string;
}

export interface Deity extends PersistableEntity {
    domains: string[];
    alignment: string;
    description: string;
    worshippers: string[];
    symbols: string[];
    clergy?: string;
}

export interface Player extends PersistableEntity {
    characters: Character[];
}

export interface SessionAttendance {
    id: number;
    session: Session;
    sessionId: number;
    player: Player;
    playerId: number;
    note?: string;
}

export interface Character extends PersistableEntity {
    player: Player;
    playerId: number;
    campaign: Campaign;
    campaignId: number;
    race: string;
    klass: string;
    level: number;
    background: string;
    alignment: string;
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

export interface Item extends PersistableEntity {
    description?: string;
    quantity: number;
    weight?: number;
    value?: number;
    type: 'weapon' | 'armor' | 'gear' | 'consumable' | 'treasure' | 'other';
}

export interface MagicItem extends Item {
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


export interface Location extends PersistableEntity {
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


export interface PointOfInterest extends PersistableEntity {
    location: Location;
    locationId: number;
    type: 'shop' | 'tavern' | 'temple' | 'guild' | 'landmark' | 'dungeon' | 'other';
    owner?: NPC;
    ownerId?: number;
    services?: string[];
    items?: Item[];
    hooks?: string[];
}


export interface Faction extends PersistableEntity {
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


export interface Religion extends PersistableEntity {
    deities: Deity[];
    practices: string[];
    holySymbols: string[];
    temples: Location[];
    clergy: NPC[];
    holidays: Holiday[];
    tenets: string[];
    restrictions: string[];
}

export interface Part extends PersistableEntity {
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

export interface Session extends PersistableEntity {
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

export interface Encounter extends PersistableEntity {
    description: string
}

export interface Event extends PersistableEntity {
    description: string
}

export interface SessionPlan extends PersistableEntity {
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

export interface SessionSummary extends PersistableEntity {
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

export interface NPC extends PersistableEntity {
    type: 'individual' | 'group';
    race?: string;
    klass?: string;
    occupation: string;
    appearance: string;
    personality: string;
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

export interface NPCRelationship extends PersistableEntity {
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