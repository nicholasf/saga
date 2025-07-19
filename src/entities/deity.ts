import type { Deity } from '../types/saga';

export const createDeity = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    domains: string[],
    alignment: string,
    description: string,
    worshippers: string[],
    symbols: string[],
    clergy?: string,
): Deity => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    domains,
    alignment,
    worshippers,
    symbols,
    clergy
});