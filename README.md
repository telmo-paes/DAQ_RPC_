[ 16 GPIOs ] 
     ↓
┌────────────────────────────┐
│ 1. Edge Detector (16 Channels)
│ Detecta flancos de subida
└────┬───────────────────────┘
     ↓
┌────────────────────────────┐
│ 2. Timestamp Counter (global)
│ Marca tempo com clock base
└────┬───────────────────────┘
     ↓
┌────────────────────────────┐
│ 3. Event Packager
│ Monta {strip_id, timestamp}
└────┬───────────────────────┘
     ↓
┌────────────────────────────┐
│ 4. FIFO Buffer
│ Armazena eventos
└────┬───────────────────────┘
     ↓
┌────────────────────────────┐
│ 5. UART Transmitter
│ Envia para o PC
└────────────────────────────┘
