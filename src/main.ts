import '../styles/main.scss';
import Alpine from 'alpinejs';
import PineconeRouter from 'pinecone-router';

window.Alpine = Alpine;
Alpine.plugin(PineconeRouter);

Alpine.store('routes', {
    items: [
        { path: '', name: 'Challenge', icon: 'challenge', },
        { path: 'practice', name: 'Practice', icon: 'practice', },
        { path: 'statistics', name: 'Statistics', icon: 'statistics', },
        { path: 'settings', name: 'Settings', icon: 'settings', }
    ],
});

Alpine.start();
