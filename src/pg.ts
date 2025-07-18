import { Pool, PoolConfig } from 'pg';

interface DatabaseConfig {
  port: number;
  user: string;
  password: string;
  host: string;
  database?: string;
}

/**
 * Creates and returns a database connection pool asynchronously
 * @param config Database configuration parameters
 * @returns Promise resolving to a PostgreSQL connection pool
 * @throws Error if connection fails
 */
export const createDatabaseConnection = async (config: DatabaseConfig): Promise<Pool> => {
  const poolConfig: PoolConfig = {
    user: config.user,
    host: config.host,
    password: config.password,
    port: config.port,
    database: config.database || 'postgres', // Default to 'postgres' if not specified
  };

  try {
    const pool = new Pool(poolConfig);

    // Test the connection by actually trying to connect
    await pool.connect();
    console.log('Successfully connected to PostgreSQL database');

    // Setup error handler for the pool
    pool.on('error', (err) => {
      console.error('Unexpected error on idle client', err);
      process.exit(-1);
    });

    return pool;
  } catch (error) {
    console.error('Error creating database connection:', error);
    throw error;
  }
};