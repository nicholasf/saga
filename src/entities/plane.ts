import type { Plane } from '../types/saga';

export const createPlane = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    description: string,
    inhabitants: string[],
    traits: string[],
    accessPoints?: string[],
): Plane => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    inhabitants,
    traits,
    accessPoints
});