import type { Calendar, Month, Holiday } from '../types/saga';

export const createCalendar = (
    id: number,
    name: string,
    createdAt: Date,
    updatedAt: Date,
    months: Month[],
    daysPerWeek: number,
    currentDate: string,
    holidays: Holiday[],
    description?: string,
    moonPhases?: string[],
): Calendar => ({
    id,
    name,
    description,
    createdAt,
    updatedAt,
    months,
    daysPerWeek,
    currentDate,
    holidays,
    moonPhases
});