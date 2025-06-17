import Anthropic from "@anthropic-ai/sdk";

const anthropic = new Anthropic();

export async function send(message: string): Promise<string> {
    try {
        const msg = await anthropic.messages.create({
            model: "claude-opus-4-20250514",
            max_tokens: 1000,
            temperature: 1,
            system: "Respond only with short poems.",
            messages: [
                {
                role: "user",
                content: [
                    {
                    type: "text",
                    text: "Why is the ocean salty?"
                    }
                ]
                }
            ]
        });

        if (!msg) {
            throw new Error("Missing response from Anthropic.")
        }

        let resp = JSON.stringify(msg);

        // Return the text content from the first message in the response
        return resp

    } catch (err) {
        throw err
    }
} 

