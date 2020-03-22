import React from 'react'
import './LoginForm.css'
import InputText from '../input/InputText';
import Button from '../button/Button';
import { Link } from 'react-router-dom';

class LoginForm extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            login: '',
            mdp: ''
        }
        this.handleLoginChange = this.handleLoginChange.bind(this);
        this.handleMdpChange = this.handleMdpChange.bind(this);
        this.handleConnection = this.handleConnection.bind(this);
        this.handleSubscribe = this.handleSubscribe.bind(this);
    }
    handleLoginChange(e) {
        this.setState({ login: e.target.value })
    }
    handleMdpChange(e) {
        this.setState({ mdp: e.target.value })
    }
    handleConnection(e) {
        const pseudo = this.state.login
        const mdp = this.state.mdp
        fetch(`http://localhost:3000/users/authenticate`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ pseudo: `${pseudo}`, mdp: `${mdp}` })
        })
            .then((res) => res.ok ? res.text() : "L'utilisateur n'existe pas")
            .then((res) => alert(res));
        // Le res de alert est le résultat du premier then
    }
    handleSubscribe(e) {

    }
    render() {
        return (
            <div className="LoginForm">
                <h1>Connexion</h1>
                <InputText placeholder="Pseudonyme" onChange={this.handleLoginChange} />
                <InputText placeholder="Mot de passe" hide={true} onChange={this.handleMdpChange} />
                <Button.BlueSquaredButton text="Se connecter" onClick={this.handleConnection} />
                <Link to='subscribe'>
                    <Button.BlueSquaredButton text="Pas de compte ? Inscrivez-vous !" />
                </Link>
            </div>)
    }
}
export default LoginForm