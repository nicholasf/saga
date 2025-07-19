import type { Holiday } from '../types/saga';

export const createHoliday = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    date: string,
    description: string,
    importance: 'minor' | 'major' | 'critical',
): Holiday => ({
    id,
    name,
    createdAt,
    updatedAt,
    date,
    description,
    importance
});