import { Elm } from './src/Main.elm'

const storage = {
  save: (key, value) =>
    window.localStorage.setItem(key, JSON.stringify(value)) || value,
  load: (key) =>
    JSON.parse(window.localStorage.getItem(key))
}

const app = Elm.Main.init({
  node: document.getElementById('app'),
  flags: storage.load('data')
})

app.ports.outgoing.subscribe(function (data) {
  storage.save('data', data)
})
