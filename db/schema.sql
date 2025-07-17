-- PostgreSQL Schema for Saga Campaign Management System
-- Generated from saga.d.ts TypeScript interfaces

-- Enable UUID extension for primary keys
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create ENUM types
CREATE TYPE campaign_status AS ENUM ('planning', 'active', 'hiatus', 'completed');
CREATE TYPE campaign_tone AS ENUM ('heroic', 'gritty', 'dark', 'lighthearted', 'epic', 'horror', 'comedic', 'mysterious', 'romantic', 'political');
CREATE TYPE campaign_mood AS ENUM ('hopeful', 'grim', 'whimsical', 'tense', 'melancholic', 'triumphant', 'foreboding', 'nostalgic');
CREATE TYPE maturity_level AS ENUM ('family-friendly', 'teen', 'mature', 'adult');
CREATE TYPE conflict_type AS ENUM ('personal', 'political', 'cosmic', 'moral', 'survival', 'mystery');
CREATE TYPE setting_genre AS ENUM ('high-fantasy', 'low-fantasy', 'dark-fantasy', 'urban-fantasy', 'steampunk', 'gothic', 'mythic', 'post-apocalyptic');
CREATE TYPE magic_prevalence AS ENUM ('rare', 'uncommon', 'common', 'ubiquitous');
CREATE TYPE technology_level AS ENUM ('primitive', 'medieval', 'renaissance', 'industrial', 'modern', 'futuristic');
CREATE TYPE pacing AS ENUM ('slow-burn', 'steady', 'fast-paced', 'episodic', 'milestone-driven');
CREATE TYPE complexity AS ENUM ('straightforward', 'layered', 'intricate', 'labyrinthine');
CREATE TYPE player_agency AS ENUM ('high', 'medium', 'guided', 'on-rails');
CREATE TYPE violence_level AS ENUM ('minimal', 'moderate', 'realistic', 'graphic');
CREATE TYPE social_complexity AS ENUM ('simple', 'moderate', 'intricate', 'byzantine');
CREATE TYPE moral_ambiguity AS ENUM ('clear', 'nuanced', 'gray', 'subversive');
CREATE TYPE rules_emphasis AS ENUM ('strict', 'flexible', 'narrative-first', 'rule-of-cool');
CREATE TYPE world_type AS ENUM ('planet', 'plane', 'realm', 'dimension', 'other');
CREATE TYPE holiday_importance AS ENUM ('minor', 'major', 'critical');
CREATE TYPE historical_significance AS ENUM ('minor', 'major', 'world-changing');
CREATE TYPE event_importance AS ENUM ('background', 'minor', 'major', 'critical');
CREATE TYPE event_status AS ENUM ('brewing', 'ongoing', 'resolving', 'aftermath');
CREATE TYPE plane_connection_type AS ENUM ('portal', 'overlap', 'ritual', 'natural', 'other');
CREATE TYPE connection_stability AS ENUM ('permanent', 'stable', 'fluctuating', 'temporary');
CREATE TYPE character_status AS ENUM ('active', 'inactive', 'deceased');
CREATE TYPE item_type AS ENUM ('weapon', 'armor', 'gear', 'consumable', 'treasure', 'other');
CREATE TYPE magic_item_rarity AS ENUM ('common', 'uncommon', 'rare', 'very rare', 'legendary', 'artifact');
CREATE TYPE location_type AS ENUM ('continent', 'region', 'city', 'town', 'village', 'dungeon', 'wilderness', 'building', 'other');
CREATE TYPE poi_type AS ENUM ('shop', 'tavern', 'temple', 'guild', 'landmark', 'dungeon', 'other');
CREATE TYPE faction_status AS ENUM ('growing', 'stable', 'declining', 'hidden', 'defunct');
CREATE TYPE relationship_type AS ENUM ('allied', 'friendly', 'neutral', 'unfriendly', 'hostile', 'unknown');
CREATE TYPE part_status AS ENUM ('planned', 'active', 'completed', 'abandoned');
CREATE TYPE npc_type AS ENUM ('individual', 'group');
CREATE TYPE npc_status AS ENUM ('alive', 'deceased', 'unknown');
CREATE TYPE npc_importance AS ENUM ('background', 'minor', 'major', 'villain', 'ally');
CREATE TYPE npc_relationship_type AS ENUM ('ally', 'enemy', 'family', 'romantic', 'professional', 'other');
CREATE TYPE relationship_intensity AS ENUM ('weak', 'moderate', 'strong');
CREATE TYPE reward_type AS ENUM ('gold', 'item', 'experience', 'favor', 'information', 'other');
CREATE TYPE target_type AS ENUM ('npc', 'character');

-- Base entities table (for inheritance-like behavior)
CREATE TABLE entities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Worlds table
CREATE TABLE worlds (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    type world_type NOT NULL,
    geography TEXT,
    climate TEXT,
    races TEXT[],
    technology TEXT,
    magic TEXT
);

-- Calendars table
CREATE TABLE calendars (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    days_per_week INTEGER NOT NULL,
    current_date VARCHAR(255),
    moon_phases TEXT[]
);

-- Months table
CREATE TABLE months (
    id SERIAL PRIMARY KEY,
    calendar_id INTEGER REFERENCES calendars(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    days_count INTEGER NOT NULL,
    season VARCHAR(255)
);

-- Holidays table
CREATE TABLE holidays (
    id SERIAL PRIMARY KEY,
    calendar_id INTEGER REFERENCES calendars(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    date VARCHAR(255) NOT NULL,
    description TEXT,
    importance holiday_importance NOT NULL
);

-- Cosmologies table
CREATE TABLE cosmologies (
    id SERIAL PRIMARY KEY
);

-- Planes table
CREATE TABLE planes (
    id SERIAL PRIMARY KEY,
    cosmology_id INTEGER REFERENCES cosmologies(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    inhabitants TEXT[],
    traits TEXT[],
    access_points TEXT[]
);

-- Plane connections table
CREATE TABLE plane_connections (
    id SERIAL PRIMARY KEY,
    source_plane_id INTEGER REFERENCES planes(id) ON DELETE CASCADE,
    target_plane_id INTEGER REFERENCES planes(id) ON DELETE CASCADE,
    type plane_connection_type NOT NULL,
    stability connection_stability NOT NULL,
    description TEXT
);

-- Deities table
CREATE TABLE deities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    cosmology_id INTEGER REFERENCES cosmologies(id) ON DELETE CASCADE,
    domains TEXT[],
    alignment VARCHAR(255),
    worshippers TEXT[],
    symbols TEXT[],
    clergy TEXT
);

-- Campaign prompts table
CREATE TABLE campaign_prompts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    tone campaign_tone NOT NULL,
    mood campaign_mood NOT NULL,
    maturity_level maturity_level NOT NULL,
    primary_themes TEXT[],
    conflict_types conflict_type[],
    setting_genre setting_genre NOT NULL,
    magic_prevalence magic_prevalence NOT NULL,
    technology_level technology_level NOT NULL,
    pacing pacing NOT NULL,
    complexity complexity NOT NULL,
    player_agency player_agency NOT NULL,
    violence_level violence_level NOT NULL,
    social_complexity social_complexity NOT NULL,
    moral_ambiguity moral_ambiguity NOT NULL,
    inspiration_sources TEXT[],
    key_words TEXT[],
    avoidance_list TEXT[],
    rules_emphasis rules_emphasis NOT NULL,
    homebrew_friendly BOOLEAN DEFAULT FALSE
);

-- Settings table
CREATE TABLE settings (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    world_id INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    era VARCHAR(255),
    calendar_id INTEGER REFERENCES calendars(id) ON DELETE SET NULL,
    cosmology_id INTEGER REFERENCES cosmologies(id) ON DELETE SET NULL
);

-- Historical events table
CREATE TABLE historical_events (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    setting_id INTEGER REFERENCES settings(id) ON DELETE CASCADE,
    date VARCHAR(255),
    significance historical_significance NOT NULL,
    participants TEXT[],
    consequences TEXT[]
);

-- Locations table
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    parent_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    setting_id INTEGER REFERENCES settings(id) ON DELETE CASCADE,
    type location_type NOT NULL,
    government TEXT,
    population INTEGER,
    races TEXT[],
    economy TEXT,
    defenses TEXT,
    rumors TEXT[],
    secrets TEXT[],
    climate TEXT,
    terrain TEXT,
    history TEXT
);

-- Factions table
CREATE TABLE factions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    setting_id INTEGER REFERENCES settings(id) ON DELETE CASCADE,
    leader_id INTEGER, -- References NPCs, will be added later
    goals TEXT[],
    methods TEXT[],
    resources TEXT[],
    status faction_status NOT NULL,
    player_relationship relationship_type NOT NULL,
    insignia TEXT,
    hierarchy TEXT
);

-- Religions table
CREATE TABLE religions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    setting_id INTEGER REFERENCES settings(id) ON DELETE CASCADE,
    practices TEXT[],
    holy_symbols TEXT[],
    tenets TEXT[],
    restrictions TEXT[]
);

-- Players table
CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Campaigns table
CREATE TABLE campaigns (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    inception DATE NOT NULL,
    end_date DATE,
    setting_id INTEGER REFERENCES settings(id) ON DELETE CASCADE,
    prompt_id INTEGER REFERENCES campaign_prompts(id) ON DELETE CASCADE,
    current_level INTEGER DEFAULT 1,
    status campaign_status NOT NULL
);

-- Campaign players (many-to-many)
CREATE TABLE campaign_players (
    campaign_id INTEGER REFERENCES campaigns(id) ON DELETE CASCADE,
    player_id INTEGER REFERENCES players(id) ON DELETE CASCADE,
    PRIMARY KEY (campaign_id, player_id)
);

-- Characters table
CREATE TABLE characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    player_id INTEGER REFERENCES players(id) ON DELETE CASCADE,
    campaign_id INTEGER REFERENCES campaigns(id) ON DELETE CASCADE,
    race VARCHAR(255),
    class VARCHAR(255),
    level INTEGER DEFAULT 1,
    background TEXT,
    alignment VARCHAR(255),
    strength INTEGER,
    dexterity INTEGER,
    constitution INTEGER,
    intelligence INTEGER,
    wisdom INTEGER,
    charisma INTEGER,
    experience INTEGER DEFAULT 0,
    personality_traits TEXT[],
    ideals TEXT[],
    bonds TEXT[],
    flaws TEXT[],
    features TEXT,
    backstory TEXT,
    notes TEXT[],
    status character_status NOT NULL
);

-- Items table
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    quantity INTEGER DEFAULT 1,
    weight DECIMAL(10,2),
    value DECIMAL(10,2),
    type item_type NOT NULL,
    character_id INTEGER REFERENCES characters(id) ON DELETE CASCADE,
    campaign_id INTEGER REFERENCES campaigns(id) ON DELETE CASCADE
);

-- Magic items table
CREATE TABLE magic_items (
    id SERIAL PRIMARY KEY,
    item_id INTEGER REFERENCES items(id) ON DELETE CASCADE,
    campaign_id INTEGER REFERENCES campaigns(id) ON DELETE CASCADE,
    rarity magic_item_rarity NOT NULL,
    attunement BOOLEAN DEFAULT FALSE,
    attuned_by_id INTEGER REFERENCES characters(id) ON DELETE SET NULL,
    max_charges INTEGER,
    current_charges INTEGER,
    recharge TEXT,
    effects TEXT[]
);

-- NPCs table
CREATE TABLE npcs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    campaign_id INTEGER REFERENCES campaigns(id) ON DELETE CASCADE,
    type npc_type NOT NULL,
    race VARCHAR(255),
    class VARCHAR(255),
    occupation VARCHAR(255),
    appearance TEXT,
    personality TEXT,
    strength INTEGER,
    dexterity INTEGER,
    constitution INTEGER,
    intelligence INTEGER,
    wisdom INTEGER,
    charisma INTEGER,
    motivation TEXT,
    goals TEXT[],
    secrets TEXT[],
    location_id INTEGER REFERENCES locations(id) ON DELETE SET NULL,
    faction_id INTEGER REFERENCES factions(id) ON DELETE SET NULL,
    status npc_status NOT NULL,
    importance npc_importance NOT NULL,
    first_appearance_id INTEGER, -- References sessions, will be added later
    voice TEXT,
    mannerisms TEXT[],
    quotes TEXT[],
    is_unique BOOLEAN DEFAULT TRUE
);

-- Add foreign key constraint for faction leader
ALTER TABLE factions ADD CONSTRAINT fk_faction_leader FOREIGN KEY (leader_id) REFERENCES npcs(id) ON DELETE SET NULL;

-- Points of interest table
CREATE TABLE points_of_interest (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    type poi_type NOT NULL,
    owner_id INTEGER REFERENCES npcs(id) ON DELETE SET NULL,
    services TEXT[],
    hooks TEXT[]
);

-- Current events table
CREATE TABLE current_events (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    setting_id INTEGER REFERENCES settings(id) ON DELETE CASCADE,
    importance event_importance NOT NULL,
    status event_status NOT NULL
);

-- Parts table
CREATE TABLE parts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    campaign_id INTEGER REFERENCES campaigns(id) ON DELETE CASCADE,
    summary TEXT,
    status part_status NOT NULL,
    plot_twists TEXT[],
    climax TEXT,
    resolution TEXT,
    next_part_id INTEGER REFERENCES parts(id) ON DELETE SET NULL,
    previous_part_id INTEGER REFERENCES parts(id) ON DELETE SET NULL,
    order_number INTEGER NOT NULL
);

-- Sessions table
CREATE TABLE sessions (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    part_id INTEGER REFERENCES parts(id) ON DELETE CASCADE,
    number INTEGER NOT NULL,
    date DATE,
    duration INTEGER, -- In hours
    discoveries TEXT[],
    next_session_id INTEGER REFERENCES sessions(id) ON DELETE SET NULL
);

-- Add foreign key constraint for NPC first appearance
ALTER TABLE npcs ADD CONSTRAINT fk_npc_first_appearance FOREIGN KEY (first_appearance_id) REFERENCES sessions(id) ON DELETE SET NULL;

-- Encounters table
CREATE TABLE encounters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Events table
CREATE TABLE events (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Session plans table
CREATE TABLE session_plans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    session_id INTEGER REFERENCES sessions(id) ON DELETE CASCADE,
    goals TEXT[],
    opening_scene TEXT,
    contingencies TEXT[],
    secrets TEXT[]
);

-- Session summaries table
CREATE TABLE session_summaries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    session_id INTEGER REFERENCES sessions(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    narrative TEXT,
    highlights TEXT[],
    next_session_hooks TEXT[]
);

-- Session attendance table
CREATE TABLE session_attendance (
    id SERIAL PRIMARY KEY,
    session_id INTEGER REFERENCES sessions(id) ON DELETE CASCADE,
    player_id INTEGER REFERENCES players(id) ON DELETE CASCADE,
    note TEXT,
    UNIQUE(session_id, player_id)
);

-- Session rewards table
CREATE TABLE session_rewards (
    id SERIAL PRIMARY KEY,
    session_summary_id INTEGER REFERENCES session_summaries(id) ON DELETE CASCADE,
    type reward_type NOT NULL,
    description TEXT,
    value INTEGER,
    item_id INTEGER REFERENCES magic_items(id) ON DELETE SET NULL
);

-- NPC relationships table
CREATE TABLE npc_relationships (
    id SERIAL PRIMARY KEY,
    source_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    target_id INTEGER NOT NULL,
    target_type target_type NOT NULL,
    type npc_relationship_type NOT NULL,
    description TEXT,
    intensity relationship_intensity NOT NULL,
    is_public BOOLEAN DEFAULT TRUE
);

-- Many-to-many relationship tables

-- Current event locations
CREATE TABLE current_event_locations (
    current_event_id INTEGER REFERENCES current_events(id) ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    PRIMARY KEY (current_event_id, location_id)
);

-- Current event factions
CREATE TABLE current_event_factions (
    current_event_id INTEGER REFERENCES current_events(id) ON DELETE CASCADE,
    faction_id INTEGER REFERENCES factions(id) ON DELETE CASCADE,
    PRIMARY KEY (current_event_id, faction_id)
);

-- Current event NPCs
CREATE TABLE current_event_npcs (
    current_event_id INTEGER REFERENCES current_events(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (current_event_id, npc_id)
);

-- Faction locations
CREATE TABLE faction_locations (
    faction_id INTEGER REFERENCES factions(id) ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    PRIMARY KEY (faction_id, location_id)
);

-- Faction allies
CREATE TABLE faction_allies (
    faction_id INTEGER REFERENCES factions(id) ON DELETE CASCADE,
    ally_id INTEGER REFERENCES factions(id) ON DELETE CASCADE,
    PRIMARY KEY (faction_id, ally_id)
);

-- Faction enemies
CREATE TABLE faction_enemies (
    faction_id INTEGER REFERENCES factions(id) ON DELETE CASCADE,
    enemy_id INTEGER REFERENCES factions(id) ON DELETE CASCADE,
    PRIMARY KEY (faction_id, enemy_id)
);

-- Religion deities
CREATE TABLE religion_deities (
    religion_id INTEGER REFERENCES religions(id) ON DELETE CASCADE,
    deity_id INTEGER REFERENCES deities(id) ON DELETE CASCADE,
    PRIMARY KEY (religion_id, deity_id)
);

-- Religion temples
CREATE TABLE religion_temples (
    religion_id INTEGER REFERENCES religions(id) ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    PRIMARY KEY (religion_id, location_id)
);

-- Religion clergy
CREATE TABLE religion_clergy (
    religion_id INTEGER REFERENCES religions(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (religion_id, npc_id)
);

-- Religion holidays
CREATE TABLE religion_holidays (
    religion_id INTEGER REFERENCES religions(id) ON DELETE CASCADE,
    holiday_id INTEGER REFERENCES holidays(id) ON DELETE CASCADE,
    PRIMARY KEY (religion_id, holiday_id)
);

-- Part main NPCs
CREATE TABLE part_main_npcs (
    part_id INTEGER REFERENCES parts(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (part_id, npc_id)
);

-- Part key locations
CREATE TABLE part_key_locations (
    part_id INTEGER REFERENCES parts(id) ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    PRIMARY KEY (part_id, location_id)
);

-- Session locations
CREATE TABLE session_locations (
    session_id INTEGER REFERENCES sessions(id) ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    PRIMARY KEY (session_id, location_id)
);

-- Session NPCs
CREATE TABLE session_npcs (
    session_id INTEGER REFERENCES sessions(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (session_id, npc_id)
);

-- Session plan encounters
CREATE TABLE session_plan_encounters (
    session_plan_id INTEGER REFERENCES session_plans(id) ON DELETE CASCADE,
    encounter_id INTEGER REFERENCES encounters(id) ON DELETE CASCADE,
    PRIMARY KEY (session_plan_id, encounter_id)
);

-- Session plan events
CREATE TABLE session_plan_events (
    session_plan_id INTEGER REFERENCES session_plans(id) ON DELETE CASCADE,
    event_id INTEGER REFERENCES events(id) ON DELETE CASCADE,
    PRIMARY KEY (session_plan_id, event_id)
);

-- Session plan key NPCs
CREATE TABLE session_plan_key_npcs (
    session_plan_id INTEGER REFERENCES session_plans(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (session_plan_id, npc_id)
);

-- Session plan locations
CREATE TABLE session_plan_locations (
    session_plan_id INTEGER REFERENCES session_plans(id) ON DELETE CASCADE,
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    PRIMARY KEY (session_plan_id, location_id)
);

-- Session summary attendees
CREATE TABLE session_summary_attendees (
    session_summary_id INTEGER REFERENCES session_summaries(id) ON DELETE CASCADE,
    player_id INTEGER REFERENCES players(id) ON DELETE CASCADE,
    PRIMARY KEY (session_summary_id, player_id)
);

-- Session summary loot
CREATE TABLE session_summary_loot (
    session_summary_id INTEGER REFERENCES session_summaries(id) ON DELETE CASCADE,
    item_id INTEGER REFERENCES items(id) ON DELETE CASCADE,
    PRIMARY KEY (session_summary_id, item_id)
);

-- Character allies
CREATE TABLE character_allies (
    character_id INTEGER REFERENCES characters(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (character_id, npc_id)
);

-- Character enemies
CREATE TABLE character_enemies (
    character_id INTEGER REFERENCES characters(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (character_id, npc_id)
);

-- NPC inventory
CREATE TABLE npc_inventory (
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    item_id INTEGER REFERENCES items(id) ON DELETE CASCADE,
    PRIMARY KEY (npc_id, item_id)
);

-- Point of interest items
CREATE TABLE poi_items (
    poi_id INTEGER REFERENCES points_of_interest(id) ON DELETE CASCADE,
    item_id INTEGER REFERENCES items(id) ON DELETE CASCADE,
    PRIMARY KEY (poi_id, item_id)
);

-- Location key NPCs
CREATE TABLE location_key_npcs (
    location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    npc_id INTEGER REFERENCES npcs(id) ON DELETE CASCADE,
    PRIMARY KEY (location_id, npc_id)
);

-- Create indexes for better performance
CREATE INDEX idx_campaigns_status ON campaigns(status);
CREATE INDEX idx_characters_player_id ON characters(player_id);
CREATE INDEX idx_characters_campaign_id ON characters(campaign_id);
CREATE INDEX idx_npcs_campaign_id ON npcs(campaign_id);
CREATE INDEX idx_npcs_location_id ON npcs(location_id);
CREATE INDEX idx_npcs_faction_id ON npcs(faction_id);
CREATE INDEX idx_sessions_part_id ON sessions(part_id);
CREATE INDEX idx_parts_campaign_id ON parts(campaign_id);
CREATE INDEX idx_locations_parent_id ON locations(parent_id);
CREATE INDEX idx_locations_setting_id ON locations(setting_id);
CREATE INDEX idx_items_character_id ON items(character_id);
CREATE INDEX idx_items_campaign_id ON items(campaign_id);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at columns
CREATE TRIGGER update_entities_updated_at BEFORE UPDATE ON entities FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_worlds_updated_at BEFORE UPDATE ON worlds FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_campaign_prompts_updated_at BEFORE UPDATE ON campaign_prompts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_settings_updated_at BEFORE UPDATE ON settings FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_historical_events_updated_at BEFORE UPDATE ON historical_events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_locations_updated_at BEFORE UPDATE ON locations FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_factions_updated_at BEFORE UPDATE ON factions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_religions_updated_at BEFORE UPDATE ON religions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_players_updated_at BEFORE UPDATE ON players FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_campaigns_updated_at BEFORE UPDATE ON campaigns FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_characters_updated_at BEFORE UPDATE ON characters FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_npcs_updated_at BEFORE UPDATE ON npcs FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_points_of_interest_updated_at BEFORE UPDATE ON points_of_interest FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_current_events_updated_at BEFORE UPDATE ON current_events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_parts_updated_at BEFORE UPDATE ON parts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sessions_updated_at BEFORE UPDATE ON sessions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_encounters_updated_at BEFORE UPDATE ON encounters FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_session_plans_updated_at BEFORE UPDATE ON session_plans FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_session_summaries_updated_at BEFORE UPDATE ON session_summaries FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_deities_updated_at BEFORE UPDATE ON deities FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();