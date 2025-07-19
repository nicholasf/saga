import type { Character, Player, Campaign, Item, NPC } from '../types/saga';

export const createCharacter = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    player: Player,
    playerId: number,
    campaign: Campaign,
    campaignId: number,
    race: string,
    klass: string,
    level: number,
    background: string,
    alignment: string,
    experience: number,
    personality: {
        traits?: string[];
        ideals?: string[];
        bonds?: string[];
        flaws?: string[];
    },
    inventory: Item[],
    features: string,
    status: 'active' | 'inactive' | 'deceased',
    description?: string,
    backstory?: string,
    allies?: NPC[],
    enemies?: NPC[],
    notes?: string[],
): Character => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    player,
    playerId,
    campaign,
    campaignId,
    race,
    klass,
    level,
    background,
    alignment,
    experience,
    personality,
    inventory,
    features,
    status,
    backstory,
    allies,
    enemies,
    notes
});