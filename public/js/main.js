const CONTACT_EMAIL = "jon@groundworksecurity.com";

function toggleNav() {
  const nav = document.querySelector(".nav");
  const open = nav.classList.toggle("open");
  document.querySelector(".nav-toggle").setAttribute("aria-expanded", String(open));
}

function closeNav() {
  document.querySelector(".nav")?.classList.remove("open");
}

async function handleContact(event) {
  event.preventDefault();
  const form = event.currentTarget;
  const status = document.getElementById("form-status");
  const submit = form.querySelector("button[type='submit']");
  const data = new FormData(form);
  const frameworks = data.getAll("frameworks").join(", ") || "Not specified";

  const payload = {
    name: data.get("name"),
    email: data.get("email"),
    company: data.get("company"),
    role: data.get("role"),
    cloud: data.get("cloud"),
    timeline: data.get("timeline"),
    frameworks,
    message: data.get("message"),
    _subject: `Groundwork inquiry from ${data.get("company") || data.get("name")}`,
    _template: "table",
    _captcha: "false",
  };

  status.textContent = "Sending…";
  status.className = "form-status";
  submit.disabled = true;

  try {
    const response = await fetch(`https://formsubmit.co/ajax/${CONTACT_EMAIL}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
      body: JSON.stringify(payload),
    });

    if (!response.ok) {
      throw new Error("Form service unavailable");
    }

    window.location.href = "/thank-you";
  } catch (error) {
    const body = [
      `Name: ${payload.name}`,
      `Email: ${payload.email}`,
      `Company: ${payload.company}`,
      `Role: ${payload.role}`,
      `Cloud: ${payload.cloud}`,
      `Timeline: ${payload.timeline}`,
      `Frameworks: ${frameworks}`,
      "",
      payload.message || "",
    ].join("\n");

    window.location.href = `mailto:${CONTACT_EMAIL}?subject=${encodeURIComponent(payload._subject)}&body=${encodeURIComponent(body)}`;
    status.textContent = "Opening your email app as a backup. If nothing opens, write Jon at " + CONTACT_EMAIL + ".";
    status.className = "form-status err";
    submit.disabled = false;
  }
}

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll('.nav-links a').forEach((link) => {
    link.addEventListener("click", closeNav);
  });

  const form = document.getElementById("contact-form");
  form?.addEventListener("submit", handleContact);
});
