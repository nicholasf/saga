import type { PlaneConnection, Plane } from '../types/saga';

export const createPlaneConnection = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    sourcePlane: Plane,
    sourcePlaneId: number,
    targetPlane: Plane,
    targetPlaneId: number,
    type: 'portal' | 'overlap' | 'ritual' | 'natural' | 'other',
    stability: 'permanent' | 'stable' | 'fluctuating' | 'temporary',
    description?: string,
): PlaneConnection => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    sourcePlane,
    sourcePlaneId,
    targetPlane,
    targetPlaneId,
    type,
    stability
});