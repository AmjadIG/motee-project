import React from 'react'
import './Button.css'

const Button = {
    GrayHoverButton: function GrayHoverButton(props) {
        return (
            <button className='GrayHoverButton' onClick={props.onClick}>{props.text}</button>
        )
    },
    GreenHoverButton: function GreenHoverButton(props) {
        return (
            <button className='GreenHoverButton' onClick={props.onClick}>{props.text}</button>
        )
    },
    NavbarHoverButton : function NavbarHoverButton(props) {
        return (
            <button className='NavbarHoverButton' onClick={props.onClick}>{props.text}</button>
        )
    },
    BlueSquaredButton : function BlueSquaredButton(props) {
        return (
            <button className='BlueSquaredButton' onClick={props.onClick}>{props.text}</button>
        )
    }
}

export default Button