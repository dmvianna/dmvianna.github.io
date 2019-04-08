import './main.css';
import { Elm } from './Main.elm';
import * as resume from '../public/resume.json';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: { initJson: JSON.stringify(resume.default),
    width: window.innerWidth,
    height: window.innerHeight
  }
});

registerServiceWorker();
