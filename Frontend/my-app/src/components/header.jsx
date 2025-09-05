
const Header = () => {
    const handleRefresh = () => {
        window.location.reload();
    };

    return (
        <header className="w-full flex items-center justify-between p-4 bg-cyan-700 shadow-md">
            {/* Name on the left */}
            <h1 className="text-xl font-bold text-white">Chittaranjan Saha</h1>


            {/* Profile + Refresh button on the right */}
            <div className="flex items-center space-x-6 lg:space-x-8">
                {/* Profile Photo */}
                <img
                    src="/assets/photo.jpg"
                    alt="Profile"
                    className="w-10 h-10 rounded-full object-cover border-2 border-yellow-300"
                />

                {/* Refresh Button */}
                <button
                    onClick={handleRefresh}
                    className="px-4 py-1.5 bg-amber-800 text-white font-semibold rounded-lg hover:bg-amber-900 transition"
                >
                    Refresh
                </button>
            </div>
        </header>
    );
};

export default Header;
