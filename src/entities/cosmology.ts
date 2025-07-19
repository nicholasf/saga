import type { Cosmology, Plane, PlaneConnection, Deity } from '../types/saga';

export const createCosmology = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    planes: Plane[],
    connections: PlaneConnection[],
    deities: Deity[],
    description?: string,
): Cosmology => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    planes,
    connections,
    deities
});