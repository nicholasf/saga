import type { Campaign, Player, Character, Setting, CampaignPrompt, Part, NPC, MagicItem } from '../types/saga';
import getConfig from '../config'
import connectToPool from '../connectToPool';


export const create = async (campaign: Campaign): Promise<Campaign> => {
    var pool;
    try {
        pool = await connectToPool(getConfig())    
    }
    catch (err: unknown) {
        throw err
    }

    pool.query("SQL query to create the campaign in here..")

    return campaign
}