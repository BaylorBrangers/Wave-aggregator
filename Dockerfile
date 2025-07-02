FROM python:3.10-slim

# Install curl, gcloud SDK, and jq
RUN apt-get update && \
    apt-get install -y curl jq gnupg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY fetch_and_upload.sh ./
RUN chmod +x fetch_and_upload.sh

ENV GOBII_API_KEY="your_api_key_here"
ENV BOOK_URL="https://books.toscrape.com/catalogue/a-light-in-the-attic_1000/index.html"
ENV OUTPUT_FILE="book_data.json"
ENV GCP_BUCKET="your-gcp-bucket-name"
ENV GCP_OBJECT="books/book_data.json"

ENTRYPOINT ["/app/fetch_and_upload.sh"]

