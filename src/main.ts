import '../styles/main.scss';
import Alpine from 'alpinejs';
import PineconeRouter from 'pinecone-router';

window.Alpine = Alpine;
Alpine.plugin(PineconeRouter);
Alpine.start();
