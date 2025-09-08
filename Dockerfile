FROM barichello/godot-ci:4.4.1 AS builder
WORKDIR /app
COPY . .
RUN rm -rf build
RUN mkdir -p build
RUN godot project.godot --headless --export-release --headless "Web" ./build/index.html

FROM  nginx:alpine AS runner
COPY --from=builder /app/build /usr/share/nginx/html
LABEL org.opencontainers.image.source=https://github.com/RaspberryProgramming/typing-defense
