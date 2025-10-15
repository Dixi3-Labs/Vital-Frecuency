import React from 'react';
import { Container, Typography } from '@mui/material';

export default function Login() {
  return (
    <Container maxWidth="sm" sx={{ pt: 4 }}>
      <Typography variant="h4" gutterBottom>Login</Typography>
      <Typography variant="body1">
        Sistema de autenticación en desarrollo.
      </Typography>
    </Container>
  );
}
