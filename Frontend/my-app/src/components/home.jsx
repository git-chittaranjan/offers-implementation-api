
import ImageSlider from "./image-slider";
import RightBlock from "./right-block";


export default function HomePage() {

    return (
        <>
            <div className="flex flex-col lg:flex-row lg:items-center w-full min-h-[70vh]">
                {/* Left: Carousel */}
                <div className="flex flex-col lg:flex-col-reverse px-6">
                    <p className="text-center text-2xl font-semibold text-black m-4">
                        Offers For You
                    </p>
                    <ImageSlider />
                </div>

                {/* Right: Text Block */}
                <RightBlock />
            </div>

        </>
    );
}
