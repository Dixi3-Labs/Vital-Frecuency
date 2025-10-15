import React from 'react';
import { Container, Typography } from '@mui/material';

export default function Dashboard() {
  return (
    <Container maxWidth="lg" sx={{ pt: 4 }}>
      <Typography variant="h4" gutterBottom>Dashboard</Typography>
      <Typography variant="body1">
        Dashboard de análisis de partidas MOBA en desarrollo.
      </Typography>
    </Container>
  );
}
