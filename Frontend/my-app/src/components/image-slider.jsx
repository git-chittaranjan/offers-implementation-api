
import { useEffect, useState, useRef } from 'react';
import { ChevronLeft, ChevronRight } from 'lucide-react';

const images = [
    '/assets/banner-1.jpg',
    '/assets/banner-2.jpg',
    '/assets/banner-3.jpg',
    '/assets/banner-4.jpg',
    '/assets/banner-5.jpg',
    '/assets/Pre_Approved_Home_Loan_Offer.gif'
];

const ImageSlider = () => {
    const [currentIndex, setCurrentIndex] = useState(0);
    const [paused, setPaused] = useState(false);
    const timeoutRef = useRef(null);

    useEffect(() => {
        if (!paused) {
            timeoutRef.current = setInterval(() => {
                goToNext();
            }, 3000);
        }

        return () => clearInterval(timeoutRef.current);
    }, [currentIndex, paused]);

    const goToPrev = () => {
        setCurrentIndex((prevIndex) =>
            prevIndex === 0 ? images.length - 1 : prevIndex - 1
        );
    };

    const goToNext = () => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
    };

    return (
        <div
            className="relative w-full mx-auto overflow-hidden rounded-xl shadow-lg group"
            onMouseEnter={() => setPaused(true)}
            onMouseLeave={() => setPaused(false)}
        >
            {/* Slides */}
            <div
                className="flex transition-transform duration-700 ease-in-out h-full"
                style={{ transform: `translateX(-${currentIndex * 100}%)` }}
            >
                {images.map((src, index) => (
                    <img
                        key={index}
                        src={src}
                        alt={`Slide ${index}`}
                        className="w-full flex-shrink-0 object-cover h-full"
                    />
                ))}
            </div>

            {/* Arrows */}
            <button
                onClick={goToPrev}
                className="absolute top-1/2 left-4 -translate-y-1/2 bg-black/50 text-white p-2 rounded-full z-10 opacity-0 group-hover:opacity-100 transition"
            >
                <ChevronLeft size={24} />
            </button>
            <button
                onClick={goToNext}
                className="absolute top-1/2 right-4 -translate-y-1/2 bg-black/50 text-white p-2 rounded-full z-10 opacity-0 group-hover:opacity-100 transition"
            >
                <ChevronRight size={24} />
            </button>

            {/* Dots */}
            <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex gap-2">
                {images.map((_, index) => (
                    <button
                        key={index}
                        onClick={() => setCurrentIndex(index)}
                        className={`h-3 w-3 rounded-full ${currentIndex === index ? 'bg-white' : 'bg-white/50'
                            } transition-all duration-300`}
                    />
                ))}
            </div>
        </div>
    );
};

export default ImageSlider;
