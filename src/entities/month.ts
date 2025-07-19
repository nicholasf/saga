import type { Month } from '../types/saga';

export const createMonth = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    daysCount: number,
    season: string,
    description?: string,
): Month => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    daysCount,
    season
});