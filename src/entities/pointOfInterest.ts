import type { PointOfInterest, Location, NPC, Item } from '../types/saga';

export const createPointOfInterest = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    location: Location,
    locationId: number,
    type: 'shop' | 'tavern' | 'temple' | 'guild' | 'landmark' | 'dungeon' | 'other',
    description?: string,
    owner?: NPC,
    ownerId?: number,
    services?: string[],
    items?: Item[],
    hooks?: string[],
): PointOfInterest => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    location,
    locationId,
    type,
    owner,
    ownerId,
    services,
    items,
    hooks
});