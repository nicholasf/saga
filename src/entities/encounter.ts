import type { Encounter } from '../types/saga';

export const createEncounter = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    description: string,
): Encounter => ({
    id,
    name,
    description,
    createdAt,
    updatedAt
});