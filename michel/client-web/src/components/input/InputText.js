import React from 'react'
import './InputText.css'

function InputText(props) {
    return(
        <input className='InputText' type={props.hide ? 'password' : 'text'} placeholder={props.placeholder}/>
    ) 
}

export default InputText