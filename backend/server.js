import express from "express";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import path from "path";
import cors from "cors";
import { connectDB } from "./lib/db.js";

import authRoutes from "./routes/auth.route.js";
import productRoutes from "./routes/product.route.js";
import cartRoutes from "./routes/cart.route.js";
import analyticsRoutes from "./routes/analytics.route.js";
import orderRoutes from "./routes/order.route.js";

// Load environment variables
dotenv.config();

const app = express();

// Get environment variables with fallbacks
const CLIENT_URL = process.env.FRONTEND_ALB_DNS || 'http://localhost:3000';
const PORT = process.env.BACKEND_PORT || 5000;

// CORS setup with environment-based origin
app.use(cors({
	origin: CLIENT_URL,
	credentials: true
}));

app.use(express.json({ limit: "10mb" }));
app.use(cookieParser());

app.use("/api/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/cart", cartRoutes);
app.use("/api/analytics", analyticsRoutes);
app.use("/api", orderRoutes);

if (process.env.NODE_ENV === "production") {
	app.use(express.static(path.join(__dirname, "/frontend/dist")));

	app.get("*", (req, res) => {
		res.sendFile(path.resolve(__dirname, "frontend", "dist", "index.html"));
	});
}

// Start the server
app.listen(PORT, () => {
	console.log(`Backend is running on port ${PORT}`);
	console.log(`Accepting requests from: ${CLIENT_URL}`);
	connectDB();
});
