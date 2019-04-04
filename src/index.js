import './main.css';
import { Elm } from './Main.elm';
import * as resume from '../public/resume.json';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: JSON.stringify(resume.default)
});

registerServiceWorker();
