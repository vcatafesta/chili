/**
 * A request processor for interactive input or input from a text file. If an input file name is specified,
 * the callback function is invoked for each line in file. Otherwise, the callback function is invoked for
 * each line of interactive input until the user types "quit" or "exit".
 * @param interactivePrompt Prompt to present to user.
 * @param inputFileName Input text file name, if any.
 * @param processRequest Async callback function that is invoked for each interactive input or each line in text file.
 */
export declare function processRequests(interactivePrompt: string, inputFileName: string | undefined, processRequest: (request: string) => Promise<void>): Promise<void>;
