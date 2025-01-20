const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const authRoute = express.Router();

authRoute.post('/api/signup', async (req, res) => {
    try {
        const { fullName, email, password } = req.body;

        const existingEmail = await User.findOne({ email });

        if (existingEmail) {
            res.status(400).json({ msg: 'user with same email already exist' });

        } else {

            // generate a salt with cost factor of 10
            const salt = await bcrypt.genSalt(10);
            // hash passord using generated salt
            const hasedPassword = await bcrypt.hash(password, salt);


            var user = new User({ fullName, email, password: hasedPassword });
            user = await user.save();

            res.json({ user });
        }

    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});


authRoute.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;

        const existingUser = await User.findOne({ email });

        if (!existingUser) {
            res.status(400).json({ msg: 'user not found' });

        } else {

            const isMatch = await bcrypt.compare(password, existingUser.password);

            if (!isMatch) {
                res.status(400).json({ msg: 'password not match' });

            } else {

                const token = jwt.sign({ id: existingUser._id }, "passwordKey");

                // remove sensitive information
                const { password, _id, __v, ...userWithoutPassord } = existingUser._doc;

                res.json({ token, ...userWithoutPassord });
            }
        }

    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

module.exports = authRoute;