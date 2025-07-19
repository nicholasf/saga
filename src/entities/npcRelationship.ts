import type { NPCRelationship, NPC, Character } from '../types/saga';

export const createNPCRelationship = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    source: NPC,
    sourceId: number,
    target: NPC | Character,
    targetId: number,
    targetType: 'npc' | 'character',
    type: 'ally' | 'enemy' | 'family' | 'romantic' | 'professional' | 'other',
    description: string,
    intensity: 'weak' | 'moderate' | 'strong',
    isPublic: boolean,
): NPCRelationship => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    source,
    sourceId,
    target,
    targetId,
    targetType,
    type,
    intensity,
    isPublic
});