import type { HistoricalEvent } from '../types/saga';

export const createHistoricalEvent = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    date: string,
    significance: 'minor' | 'major' | 'world-changing',
    participants: string[],
    consequences: string[],
    description?: string,
): HistoricalEvent => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    date,
    significance,
    participants,
    consequences
});