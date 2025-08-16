
# Crush Sandbox

A disposable and secure sandbox environment for safely running the [`crush`](https://github.com/charmbracelet/crush) AI coding assistant, pre-configured for local models and offline use.


## What is this?

Running AI tools that can execute commands on your system can be risky. This project provides a safe, isolated playground using **VS Code Dev Containers**. You can let `crush` run free in YOLO mode without any risk to your main computer. When you're done, you can throw the whole environment away.

## Quick Start

### Prerequisites

1.  **Docker Desktop**: [Install Docker](https://www.docker.com/products/docker-desktop/).
2.  **VS Code**: [Install VS Code](https://code.visualstudio.com/).
3.  **Dev Containers Extension**: [Install the extension from the VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

### Setup

1.  **Clone the Repository**

    ```bash
    git clone https://github.com/ArthoPacini/crush-sandbox.git
    cd crush-sandbox
    chmod +x ./.devcontainer/prepare-image.sh
    ```

2.  **Configure `crush.json`**
    This is the **most important step**. Edit the `crush.json` file to match your setup. The provided example is for connecting to LM Studio running on your host machine. If you have an API from an provider, add it there.

3.  **Open in VS Code**
    Open the cloned folder in VS Code. A pop-up will appear in the bottom-right corner.

4.  **Reopen in Container**
    Click the "**Reopen in Container**" button. VS Code will build the Docker image and start the dev container. This might take a few minutes the first time.

5.  **Start Using It**
    Once the container is running, a terminal will open. The Python virtual environment is already activated. You can just can `crush`

-----

## Configuration (`crush.json`)

You can configure `crush` to use any provider, including OpenAI, Anthropic, or a local model server.

### Example: Connecting to a Local Model via LM Studio

The default `crush.json` is set up to connect to an LLM served by **LM Studio** on your host machine. The special address `http://host.docker.internal:1234` allows the container to talk to your computer.

```json
{
  "providers": {
    "lmstudio": {
      "name": "LM Studio",
      "base_url": "http://host.docker.internal:1234/v1/",
      "type": "openai",
      "models": [
        {
          "name": "Qwen 3 Coder 30B A3B Instruct",
          "id": "qwen3-coder-30b-a3b-instruct",
          "context_window": 262144,
          "default_max_tokens": 30000
        }
      ]
    }
  },
  "models": {
    "large": {
      "model": "qwen3-coder-30b-a3b-instruct",
      "provider": "lmstudio"
    }
  }
}
```
