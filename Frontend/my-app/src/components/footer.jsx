
import React from 'react';
import { FaGithub, FaLinkedin, FaTwitter, FaInstagram, FaFacebook, FaYoutube } from "react-icons/fa";

const Footer = () => {
    return (
        <footer className="bg-gray-900 text-white mt-8 py-8">
            <div className="container mx-auto text-center space-y-2">

                {/* Copyright Section */}
                <div className="mx-auto text-center pb-2">
                    <p className="text-sm">
                        © {new Date().getFullYear()} All rights reserved.
                    </p>
                </div>

                {/* Socail Links */}
                <div className="flex justify-center space-x-6 text-xl text-white">
                    <a
                        href="https://github.com/git-chittaranjan"
                        target="_blank"
                        rel="noreferrer"
                        className="transform transition duration-300 hover:scale-135"
                    >
                        <FaGithub />
                    </a>
                    <a
                        href="https://www.linkedin.com/in/chittaranjan-saha/"
                        target="_blank"
                        rel="noreferrer"
                        className="transform transition duration-300 hover:scale-135 hover:text-blue-500"
                    >
                        <FaLinkedin />
                    </a>
                    <a
                        href="https://x.com/"
                        target="_blank"
                        rel="noreferrer"
                        className="transform transition duration-300 hover:scale-135 hover:text-sky-500"
                    >
                        <FaTwitter />
                    </a>
                    <a
                        href="https://instagram.com/"
                        target="_blank"
                        rel="noreferrer"
                        className="transform transition duration-300 hover:scale-135 hover:text-pink-500"
                    >
                        <FaInstagram />
                    </a>
                    <a
                        href="https://facebook.com/"
                        target="_blank"
                        rel="noreferrer"
                        className="transform transition duration-300 hover:scale-135 hover:text-blue-600"
                    >
                        <FaFacebook />
                    </a>
                    <a
                        href="https://youtube.com/"
                        target="_blank"
                        rel="noreferrer"
                        className="transform transition duration-300 hover:scale-135 hover:text-red-700"
                    >
                        <FaYoutube />
                    </a>
                </div>

            </div>
        </footer>
    );
};

export default Footer;
