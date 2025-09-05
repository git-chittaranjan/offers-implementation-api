import FetchOffers from "./components/api-call"
import Footer from "./components/footer"
import Header from "./components/header"
import HomePage from "./components/home"

function App() {

  return (
    <div className="bg-blue-200">
      <Header />
      <HomePage />
      <FetchOffers />
      <Footer />
    </div>
  )
}

export default App
