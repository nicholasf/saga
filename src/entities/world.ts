import type { World } from '../types/saga';

export const createWorld = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    type: 'planet' | 'plane' | 'realm' | 'dimension' | 'other',
    geography: string,
    climate: string,
    races: string[],
    technology: string,
    magic: string,
    description?: string,
): World => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    type,
    geography,
    climate,
    races,
    technology,
    magic
});