import type { Item } from '../types/saga';

export const createItem = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    quantity: number,
    type: 'weapon' | 'armor' | 'gear' | 'consumable' | 'treasure' | 'other',
    description?: string,
    weight?: number,
    value?: number,
): Item => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    quantity,
    type,
    weight,
    value
});