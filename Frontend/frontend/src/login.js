import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function LoginPage() {
  const [name, setName] = useState('');
  const [password, setPassword] = useState('');
const navigate = useNavigate();
  const handleSubmit = (event) => {
    event.preventDefault(); // Prevents default form submission behavior

    // TODO: Call your authentication API with the name and password entered by the user
    console.log(`Name: ${name} Password: ${password}`);
    navigate('/dash');

  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Name:
        <input type="text" value={name} onChange={(event) => setName(event.target.value)} />
      </label>
      <br />
      <label>
        Password:
        <input type="password" value={password} onChange={(event) => setPassword(event.target.value)} />
      </label>
      <br />
      <button type="submit">Submit</button>
    </form>
  );
}

export default LoginPage;