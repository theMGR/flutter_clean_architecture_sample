const regexEmail = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;

const mongoose = require('mongoose');
const userSchema = mongoose.Schema(
    {
        fullName: {
            type: String,
            required: true,
            trim: true,
        },
        email: {
            type: String,
            required: true,
            trim: true,
            validate: {
                validator: (value) => {
                    return regexEmail.test(value);
                },
                message: 'Please enter valid email address',
            }
        },
        password: {
            type: String,
            required: true,
            validate: {
                validator: (value) => {
                    return value.length >= 8;
                },
                message: 'password must be atleast 8 characters long',
            }
        },
        city: {
            type: String,
            default: '',
        },
        state: {
            type: String,
            default: '',
        },
        locality: {
            type: String,
            default: '',
        }
    }
);

const user = mongoose.model('User', userSchema);

module.exports = user;