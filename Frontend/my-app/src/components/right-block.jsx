
import React from "react";

const technologies = [
    "React",
    "Tailwind",
    "react-pdf",
    "react-pdf-table",
    "Fetch API",
];

const RightBlock = () => (
    <div className="w-full px-10 lg:px-30 py-12 lg:py-0 flex flex-col justify-center">
        <h2 className="text-3xl font-bold mb-2 mt-6">Offers Integration</h2>
        <div className="w-65 h-1 bg-cyan-700 mb-4" />
        <p className="text-gray-900 text-lg font-serif leading-relaxed text-justify">
            An Offer Management System (OMS) is a centralized platform that enables businesses to create, manage, and optimize offers, 
            discounts, and promotions across various channels. It helps improve customer engagement, boost sales, and enhance brand 
            loyalty through personalized and data-driven offers. <br /><br />
            The key features of an OMS include offer creation and configuration, where marketers can define rules, validity, and 
            eligibility; customer segmentation and personalization, using analytics and AI to target specific groups; and workflow 
            automation, which accelerates approval and deployment. It also supports multi-channel distribution, ensuring consistent 
            offers across websites, apps, emails, and stores, along with real-time analytics for tracking performance and return on 
            investment.
        </p>
        <div className="pt-8">
            <div className="flex space-x-2 py-4 overflow-x-auto">
                {technologies.map((tech, index) => (
                    <span
                        key={index}
                        className="bg-yellow-500 text-black px-3 py-1 rounded-lg shadow-md whitespace-nowrap font-semibold"
                    >
                        {tech}
                    </span>
                ))}
            </div>
        </div>
    </div>
);

export default RightBlock;
