import { createTheme } from '@mui/material/styles';

const theme = createTheme({
  palette: {
    mode: 'dark',
    primary: { main: '#5e17eb' },
    secondary: { main: '#ffe600' },
    background: { default: '#191919', paper: '#222' }
  },
  typography: {
    fontFamily: 'Montserrat, Roboto, Arial, sans-serif'
  }
});

export default theme;
