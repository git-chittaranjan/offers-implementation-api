
import React from "react";

const technologies = [
    "React",
    "Tailwind",
    "react-pdf",
    "react-pdf-table",
    "Fetch API",
];

const RightBlock = () => (
    <div className="w-full px-10 lg:px-20 py-12 lg:py-0 flex flex-col justify-center">
        <h2 className="text-3xl font-bold mb-2">Offers Integration</h2>
        <div className="w-65 h-1 bg-cyan-700 mb-4" />
        <p className="text-gray-900 text-lg">
            She missed the last train. Rain poured as Maya stood beneath the flickering streetlight, shivering.
            Her phone was dead, the station deserted. A stray dog approached, wagging its tail. With a sigh, she
            sat beside it, sharing her sandwich. Minutes passed like hours. Just as despair settled in, headlights
            cut through the mist. A lone cab stopped. “Rough night?” the driver asked. She nodded, smiling. Inside,
            warmth and music greeted her. The dog barked once and vanished into the fog. Maya looked back—only paw
            prints remained. Strange comfort filled her heart. Sometimes, kindness arrives when the world feels coldest.
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
