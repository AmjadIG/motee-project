import './Navbar.css'
import { Link } from 'react-router-dom'
import React from 'react'
import Button from '../button/Button'

const Navbar = (props) => {
    return props.online ? (
        <div className='Navbar'>
            <Link to='/' className='Navbar-title'> MoTee </Link>

            <Link to='/login'>
                <Button.NavbarHoverButton text='Se connecter' />
            </Link>
            <Link to='/subscribe'>
                <Button.NavbarHoverButton text="S'inscrire" />
            </Link>
        </div>
    ) :
        (
            <div>

            </div>
        )
}

export default Navbar