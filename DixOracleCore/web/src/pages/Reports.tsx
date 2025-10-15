import React from 'react';
import { Container, Typography } from '@mui/material';

export default function Reports() {
  return (
    <Container maxWidth="lg" sx={{ pt: 4 }}>
      <Typography variant="h4" gutterBottom>Reports</Typography>
      <Typography variant="body1">
        Sistema de reportes en desarrollo.
      </Typography>
    </Container>
  );
}
