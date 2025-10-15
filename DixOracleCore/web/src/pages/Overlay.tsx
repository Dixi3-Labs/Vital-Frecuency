import React from 'react';
import { Container, Typography } from '@mui/material';

export default function Overlay() {
  return (
    <Container maxWidth="sm" sx={{ pt: 4 }}>
      <Typography variant="h4" gutterBottom>Overlay</Typography>
      <Typography variant="body1">
        Overlay en tiempo real para partidas en desarrollo.
      </Typography>
    </Container>
  );
}
