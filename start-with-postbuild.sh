#!/bin/bash
set -e

echo "Starting Vendure server..."
npm run start:server &

SERVER_PID=$!

echo "Waiting for Vendure to become healthy..."

until curl -s http://localhost:3000/health > /dev/null; do
  echo "Vendure not ready yet..."
  sleep 1
done

echo "Vendure is up. Building dashboard..."
npx vite build

echo "Dashboard build complete. Keeping server alive..."
wait $SERVER_PID
