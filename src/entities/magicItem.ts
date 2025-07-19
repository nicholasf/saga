import type { MagicItem, Character } from '../types/saga';

export const createMagicItem = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    quantity: number,
    type: 'weapon' | 'armor' | 'gear' | 'consumable' | 'treasure' | 'other',
    rarity: 'common' | 'uncommon' | 'rare' | 'very rare' | 'legendary' | 'artifact',
    attunement: boolean,
    effects: string[],
    description?: string,
    weight?: number,
    value?: number,
    attunedBy?: Character,
    charges?: {
        max: number;
        current: number;
        recharge?: string;
    },
): MagicItem => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    quantity,
    type,
    weight,
    value,
    rarity,
    attunement,
    attunedBy,
    charges,
    effects
});