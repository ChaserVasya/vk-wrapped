import { handler } from "./read-db";
import dotenv from "dotenv";

dotenv.config({ path: '.prod.local.env' });

// использую для отладки. С брейкпоинтом и дебаггером
handler();