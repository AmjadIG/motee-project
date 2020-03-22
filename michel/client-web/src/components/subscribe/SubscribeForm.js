import React from 'react'
import InputText from '../input/InputText'
import './SubscribeForm.css'
import Button from '../button/Button'
import { Link, Route, useRouteMatch } from 'react-router-dom';

function SubscribeForm(props) {
    return (
        <div className='SubscribeForm'>
            <h1>Inscription</h1>
            <InputText placeholder='Pseudonyme' />
            <InputText placeholder='Mot de passe' hide='true' />
            <InputText placeholder='Confirmer mot de passe' hide='true' />
            <InputText placeholder='Adresse mail' />
            <InputText placeholder='Ville (optionnel)' />
            <Link to='/'>
                <Button.GreenHoverButton text="S'inscrire sur MoTee" />
            </Link>
        </div>
    )
}

export default SubscribeForm