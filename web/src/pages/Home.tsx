import React from 'react';
import { Button, Container, Typography } from '@mui/material';
import { useNavigate } from 'react-router-dom';

export default function Home() {
  const navigate = useNavigate();
  return (
    <Container maxWidth="sm" sx={{ pt: 8, textAlign: "center" }}>
      <img src="/logo192.png" alt="Dix Oracle Core" width={120} />
      <Typography variant="h3" gutterBottom>Dix Oracle Core</Typography>
      <Typography variant="h6" gutterBottom>
        Transparencia y análisis avanzado para tus partidas MOBA.
      </Typography>
      <Button
        variant="contained"
        color="primary"
        size="large"
        sx={{ mt: 4 }}
        onClick={() => navigate('/dashboard')}
      >
        Ir al Dashboard
      </Button>
    </Container>
  );
}
