import type { SessionSummary, Session, Player, Item, SessionAttendance, MagicItem } from '../types/saga';

export const createSessionSummary = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    session: Session,
    sessionId: number,
    date: Date,
    attendees: Player[],
    narrative: string,
    highlights: string[],
    attendance: SessionAttendance[],
    description?: string,
    loot?: Item[],
    nextSessionHooks?: string[],
    rewards?: {
        type: 'gold' | 'item' | 'experience' | 'favor' | 'information' | 'other';
        description: string;
        value?: number;
        item?: MagicItem;
        itemId?: number;
    }[],
): SessionSummary => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    session,
    sessionId,
    date,
    attendees,
    narrative,
    highlights,
    attendance,
    loot,
    nextSessionHooks,
    rewards
});