import type { Religion, Deity, Location, NPC, Holiday } from '../types/saga';

export const createReligion = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    deities: Deity[],
    practices: string[],
    holySymbols: string[],
    temples: Location[],
    clergy: NPC[],
    holidays: Holiday[],
    tenets: string[],
    restrictions: string[],
    description?: string,
): Religion => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    deities,
    practices,
    holySymbols,
    temples,
    clergy,
    holidays,
    tenets,
    restrictions
});