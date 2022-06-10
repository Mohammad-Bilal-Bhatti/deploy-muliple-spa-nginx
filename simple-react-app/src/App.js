import { lazy } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

const Home = lazy(() => import('./pages/Home'));
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Blog = lazy(() => import('./pages/Blog'));
const About = lazy(() => import('./pages/About'));

const PUBLIC_URL = process.env.PUBLIC_URL;

function App() {
  return (
    <div className="App">
      <Router>
        <Routes>
          <Route index path={`${PUBLIC_URL}/`} element={<Home />} />
          <Route path={`${PUBLIC_URL}/dashboard`} element={<Dashboard />} />
          <Route path={`${PUBLIC_URL}/about`} element={<About />} />
          <Route path={`${PUBLIC_URL}/blog`} element={<Blog />} />
        </Routes>
      </Router>

    </div>
  );
}

export default App;
