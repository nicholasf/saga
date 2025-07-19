import type { CurrentEvent, Location, Faction, NPC } from '../types/saga';

export const createCurrentEvent = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    locations: Location[],
    factions: Faction[],
    npcs: NPC[],
    importance: 'background' | 'minor' | 'major' | 'critical',
    status: 'brewing' | 'ongoing' | 'resolving' | 'aftermath',
    description?: string,
): CurrentEvent => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    locations,
    factions,
    npcs,
    importance,
    status
});