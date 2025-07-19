export interface Config {
    logLevel: string
}

export interface Database extends Config {
    readonly user: string,
    readonly password: string,
    readonly host: string,
    readonly port: string
    readonly name: string,
}

export default (): Database => {
    return {
        user: process.env.DB_USER!,
        password: process.env.DB_PASSWORD!,
        host: process.env.DB_HOST!,
        port: process.env.DB_PORT!,
        name: process.env.DB_NAME!,
        logLevel: "debug"
    }
}
