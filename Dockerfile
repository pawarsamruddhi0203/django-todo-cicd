# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3-distutils \
    build-essential \
    libffi-dev \
   
    && rm -rf /var/lib/apt/lists/*


# Set the working directory in the container
WORKDIR /app

# Upgrade pip and install required dependencies
RUN pip install --upgrade pip && \
    pip install django==3.2

# Copy the current directory contents into the container at /app
COPY . /app/

# Set environment variable to ensure output is logged immediately
ENV PYTHONUNBUFFERED 1

# Expose port 8001 for the app
EXPOSE 8001

# Run database migrations and start the development server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8001"]

