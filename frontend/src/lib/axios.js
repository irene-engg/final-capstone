import axios from "axios";

const backendUrl = import.meta.env.VITE_BACKEND_URL || 
	(import.meta.env.MODE === "development" 
		? "http://localhost:5000/api" 
		: "/api");

const axiosInstance = axios.create({
	baseURL: backendUrl,
	withCredentials: true, 
});

// Add a request interceptor to attach the auth token to all requests
axiosInstance.interceptors.request.use(
	(config) => {
		const token = localStorage.getItem("authToken");
		if (token) {
			config.headers.Authorization = `Bearer ${token}`;
		}
		return config;
	},
	(error) => {
		return Promise.reject(error);
	}
);

export default axiosInstance;

