import type { Event } from '../types/saga';

export const createEvent = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    description: string,
): Event => ({
    id,
    name,
    description,
    createdAt,
    updatedAt
});