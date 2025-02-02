import { Alpine as AlpineType } from 'alpinejs';
import PineconeRouterType from 'pinecone-router';

declare global {
    interface Window {
        Alpine: AlpineType;
        PineconeRouter: PineconeRouterType
    };
}
