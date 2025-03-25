from flask import Flask, request, send_file
import os
import uuid
import subprocess

app = Flask(__name__)

@app.route('/generate', methods=['POST'])
def generate_video():
    if 'image' not in request.files or 'audio' not in request.files:
        return {'error': 'Missing image or audio'}, 400

    image = request.files['image']
    audio = request.files['audio']

    image_path = f"/tmp/{uuid.uuid4()}.jpg"
    audio_path = f"/tmp/{uuid.uuid4()}.wav"
    output_path = f"/tmp/{uuid.uuid4()}.mp4"

    image.save(image_path)
    audio.save(audio_path)

    cmd = [
        "python3", "scripts/inference.py",
        "--driven_audio", audio_path,
        "--source_image", image_path,
        "--result_dir", "/tmp",
        "--enhancer", "gfpgan"
    ]

    subprocess.run(cmd, check=True)

    # Tìm file output trong /tmp
    for f in os.listdir("/tmp"):
        if f.endswith(".mp4"):
            return send_file(os.path.join("/tmp", f), mimetype="video/mp4")

    return {"error": "Output not found"}, 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000)
