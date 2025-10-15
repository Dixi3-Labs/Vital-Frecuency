import React from 'react';
import { Container, Typography, Button, TextField, Box } from '@mui/material';

export default function Login() {
  return (
    <Container maxWidth="xs" sx={{ pt: 8 }}>
      <Typography variant="h4" gutterBottom textAlign="center">Login</Typography>
      <Box component="form" sx={{ mt: 3 }}>
        <TextField fullWidth label="Email" margin="normal" type="email" />
        <TextField fullWidth label="Password" margin="normal" type="password" />
        <Button fullWidth variant="contained" sx={{ mt: 3 }}>
          Iniciar Sesión
        </Button>
      </Box>
    </Container>
  );
}
