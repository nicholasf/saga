import type { Player, Character } from '../types/saga';

export const createPlayer = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    characters: Character[],
    description?: string,
): Player => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    characters
});