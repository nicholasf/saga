import type { SessionAttendance, Session, Player } from '../types/saga';

export const createSessionAttendance = (
    id: number,
    session: Session,
    sessionId: number,
    player: Player,
    playerId: number,
    note?: string,
): SessionAttendance => ({
    id,
    session,
    sessionId,
    player,
    playerId,
    note
});