### Technical Directive: Motion Control and Audio Integration Logic for Seedance 2.0

#### 1\. The Paradigm Shift: From Scene Description to Cinematic Direction

Effective immediately, all production workflows are to transition from "gacha-style" probabilistic generation to a deterministic methodology utilizing Seedance 2.0. The shift from a prompt-engineering model to an AI-powered audiovisual production system is facilitated by the Dual-Branch Diffusion Transformer (DiT) architecture. By treating video data as 3D spatiotemporal tokens rather than flat, sequential frames, the system allows the creator to function as a Technical Director rather than a passive observer. This directive establishes the standards for achieving industrial-scale reliability, ensuring that 90%+ of outputs meet broadcast requirements on the first iteration.

##### Core Technical Specifications: Seedance 2.0

Feature,Specification  
Output Resolution,Native 2K; Upscale to 4K for broadcast/social  
Clip Duration,4 to 15 seconds per shot; supports multi-shot narrative composition  
Aspect Ratios,"16:9, 9:16, 21:9 (Cinematic Widescreen), 4:3, 1:1"  
Frame Rates,24fps to 60fps Native; simulated high-speed interpolation for slow-motion  
Input Modalities,"Quad-modal: Text, Image, Video, and Audio"  
Total Asset Limit,"12 files total  (e.g., 6 images \+ 3 videos \+ 3 audio) via the @reference system"  
Quality Benchmarks,"SeedVideoBench-2.0 (Physics-aware objectives: gravity, fluid, fabric)"  
Provenance,Mandatory C2PA-compliant metadata and digital watermarking  
Industrial reliability begins with mastering precise physics and the standardized vocabulary of professional cinematography.

#### 2\. Motion Control Parameters: Natural Language Camera Logic

To achieve Director-Level Precision Control, technicians must utilize standardized cinematic vocabulary. Seedance 2.0 is architected to respond to active directorial commands that define camera interaction within 3D space. Passive scene descriptions are deprecated in favor of precise motion vectors.

##### Primary Motion Parameters

Parameter,Technical Definition,Strategic Impact,Prompt Syntax Example  
360-Degree Orbit,Full rotation around a central subject at a fixed radius.,Scrutinizes subject detail while maintaining focus; critical for product reveals.,"""Camera performs a slow 360-degree orbit around @Image1, revealing product textures."""  
Dolly Push,Physical movement of the camera forward/backward through space.,Intensifies emotional weight by forcing the viewer’s proximity to a detail.,"""Camera executes a slow dolly push-in from a medium shot to an extreme close-up on the character's eyes."""  
Crane Movement,Vertical travel combined with tilt/pan adjustments.,Enhances  spatiotemporal coherence  by providing the model with broader environmental data.,"""Camera performs a sweeping crane-up from ground level to a high-angle wide shot of the horizon."""  
Gimbal/Handheld,Introduction of kinetic secondary motion or stabilization.,Adds documentary realism or kinetic urgency; simulates physical presence.,"""Apply a subtle handheld feel to the tracking shot to increase the sense of urgency and realism."""  
While motion defines the framing, spatiotemporal logic ensures that subjects remains stable and physically plausible over time.

#### 3\. Temporal Consistency: Logic for Eliminating "Morphing" and Identity Drift

The elimination of "identity drift" is achieved through spatiotemporal tokenization. By encoding video as "3D patches," the model enforces object permanence. All generations must utilize  **ROPE (Rotary Positional Embedding)**  logic to maintain semantic coherence across long-sequence multi-shot narratives.

##### Stability Mandates for Production

1. **The @Reference System:**  Observe the 12-file ceiling. Use these assets to "lock" identity vectors. Referencing @Image1 provides a persistent anchor for facial features and textures.  
2. **The 3-Angle Rule:**  To prevent identity warping during rotation, references must include front, profile, and 3/4 views. This provides the model with necessary  **3D bone structure data** , preventing facial "melt" during head turns.  
3. **The Five-Segment Framework:**  Prompts must follow the sequence: Subject \+ Scene \+ Action \+ Camera \+ Style.  
4. **The CRAFT Framework:**  (Context \+ Reference \+ Action \+ Framing \+ Tone). This is the mandatory logic for multi-asset projects to ensure motion references (@Video) do not overwhelm visual identity references (@Image).This visual stability provides the foundation for native, perfectly synchronized audio co-creation.

#### 4\. Native Audio-Visual Synchronization and SFX Prompting

The Dual-Branch architecture enables "simultaneous co-creation." Unlike traditional post-production dubbing, the visual and audio branches are generated in parallel. Communication is handled via an  **Attention Bridge** , where visual triggers (e.g., an object breaking) signal the audio branch to generate the corresponding waveform at the exact millisecond.

##### Sync and SFX Guidelines

* **Phoneme-Level Lip-Sync:**  Support is confirmed for 10+ languages:  **ZH, EN, JA, KO, ES, FR, PT, ID, DE, RU.**  Use the Reference Real Voice command with @Audio1 to clone vocal tonalities.  
* **Audio Triggers:**  Describe the "Audio Context" to ground the visuals.  
* *Directive:*  "Background: Heavy rain hitting a tin roof, mixed with the low hum of a neon sign."  
* **Precision SFX:**  Specify timing relative to the 15-second limit.  
* *Directive:*  "Native SFX: Provide a crisp 'click' sound precisely at the 3-second mark when the character opens the metallic lid."  
* **Beat-Sync Logic:**  For choreography, use "Sync all movement transitions to the bass pulses of @Audio1."

#### 5\. Chronological Control: Speed Ramping and Time-Remapping

Technical Directors must use variable frame rates as narrative tools. While native output is 24-60fps, high-speed interpolation is used to simulate "120fps quality" for extreme slow motion.

##### Speed Ramping Logic

Technique,Prompt Phrase,Strategic Application  
Interpolated Slow-Mo,"""60fps native, simulated 120fps slow-motion""",Emphasizes micro-expressions or liquid dynamics (splashes).  
Time-Lapse,"""Accelerated time-lapse""",Demonstrates passage of time or environmental evolution.  
Physics-Aware Inertia,"""Realistic Inertia""",Mandatory  for speed changes. Forces the model to calculate the believable weight of hair and fabric.

##### The Timeline Storyboard Template

All multi-shot narratives must be time-blocked to maintain logic within the 15-second maximum:

* **0–4s:**  Shot 1 Wide shot; character enters at normal speed.  
* **4–10s:**  Shot 2 Tracking shot; ramp to slow-motion (simulated 120fps) during the leap.  
* **10–15s:**  Shot 3 Close-up; whip-pan transition back to 24fps for the landing.

#### 6\. Final Directive: Master Cinematic Direction Template

Integration of these parameters yields a 10,000x efficiency gain, moving media production into a deterministic, industrial-scale workflow. All production-grade generations must utilize the following master template.  
\#\#\# MASTER CINEMATIC DIRECTION TEMPLATE

\*\*\[CONTEXT & STYLE\]\*\*  
Style: \[e.g., Cyberpunk, Cinematic Realism\]  
Lighting: \[e.g., Tyndall effect, High-contrast neon\]  
Environment: \[Full scene description\]  
SeedVideoBench-2.0 Standard: \[e.g., Focus on realistic fluid dynamics\]

\*\*\[@REFERENCES\]\*\*  
Character Identity: @Image1 (Front), @Image2 (Profile), @Image3 (3/4 View)  
Motion/Camera Ref: @Video1  
Audio/Rhythm Ref: @Audio1  
(Total Assets: \[Count\] / 12\)

\*\*\[ACTION SEQUENCE & TIMING\]\*\*  
0-5s: \[Segment 1 Action\]  
5-10s: \[Segment 2 Action\]  
10-15s: \[Segment 3 Action\]

\*\*\[CAMERA & MOTION DIRECTION\]\*\*  
Primary Movement: \[e.g., Dolly push-in into 360-orbit\]  
Framing: \[e.g., Long shot to Close-up\]  
Physics: \[e.g., ROPE encoding consistency, Realistic fabric inertia\]

\*\*\[AUDIO & SYNC COMMANDS\]\*\*  
Dialogue/Lip-Sync: \[Text\] using @Audio1 voice profile (Language: EN).  
SFX: \[e.g., Sync 'shatter' sound to 8.5s mark\]  
Rhythm: Sync camera transitions to the beat of @Audio1.

\*\*\[METADATA & PROVENANCE\]\*\*  
Requirement: Embed C2PA Watermark  
Status: Production-Grade Directorial Script

By adhering to this directive, creators transition from generative randomness to professional, controllable cinematography.  
