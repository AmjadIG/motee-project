import React from 'react';
import './App.css';
import { Link, Route, Switch } from 'react-router-dom';
import LoginForm from './components/login/LoginForm'
import SubscribeForm from './components/subscribe/SubscribeForm'
import Home from './components/home/Home'
import Navbar from './components/navbar/Navbar';

function App() {
  return (
    <div>
      <Navbar online='true'/>
      <Switch>
        <Route path='/login'>
          <LoginForm />
        </Route>
        <Route path='/subscribe'>
          <SubscribeForm />
        </Route>
        <Route path='/'>
          <Home />
        </Route>
      </Switch>
    </div>
  );
}
export default App;
