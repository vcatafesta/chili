"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.processRequests = void 0;
const fs_1 = __importDefault(require("fs"));
const promises_1 = __importDefault(require("readline/promises"));
/**
 * A request processor for interactive input or input from a text file. If an input file name is specified,
 * the callback function is invoked for each line in file. Otherwise, the callback function is invoked for
 * each line of interactive input until the user types "quit" or "exit".
 * @param interactivePrompt Prompt to present to user.
 * @param inputFileName Input text file name, if any.
 * @param processRequest Async callback function that is invoked for each interactive input or each line in text file.
 */
async function processRequests(interactivePrompt, inputFileName, processRequest) {
    if (inputFileName) {
        const lines = fs_1.default.readFileSync(inputFileName).toString().split(/\r?\n/);
        for (const line of lines) {
            if (line.length) {
                console.log(interactivePrompt + line);
                await processRequest(line);
            }
        }
    }
    else {
        const stdio = promises_1.default.createInterface({ input: process.stdin, output: process.stdout });
        while (true) {
            const input = await stdio.question(interactivePrompt);
            if (input.toLowerCase() === "quit" || input.toLowerCase() === "exit") {
                break;
            }
            else if (input.length) {
                await processRequest(input);
            }
        }
        stdio.close();
    }
}
exports.processRequests = processRequests;
