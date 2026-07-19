const header = document.querySelector("[data-header]");
const revealEls = document.querySelectorAll(".reveal");
const tabs = document.querySelectorAll(".agent-tab");
const search = document.querySelector("#agent-search");
const caButton = document.querySelector("[data-copy-ca]");

const observer = new IntersectionObserver(
  entries => {
    for (const entry of entries) {
      if (entry.isIntersecting) entry.target.classList.add("visible");
    }
  },
  { threshold: 0.16 }
);

for (const el of revealEls) observer.observe(el);

window.addEventListener("scroll", () => {
  header.classList.toggle("scrolled", window.scrollY > 36);
});

for (const tab of tabs) {
  tab.addEventListener("click", () => {
    tabs.forEach(item => item.classList.remove("active"));
    tab.classList.add("active");
    document.documentElement.style.setProperty("--agent-accent", tab.dataset.agent === "Risk" ? "#78ffcf" : tab.dataset.agent === "Volume" ? "#9b7cff" : "#ff2366");
  });
}

document.querySelector("[data-search]")?.addEventListener("click", () => {
  const q = (search.value || "").toLowerCase();
  for (const tab of tabs) {
    tab.hidden = q.length > 0 && !tab.textContent.toLowerCase().includes(q);
  }
});

caButton?.addEventListener("click", async () => {
  const originalText = caButton.textContent.trim();
  const copyText = originalText.replace(/^CA:\s*/i, "");

  try {
    await navigator.clipboard.writeText(copyText);
    caButton.textContent = "Copied";
    caButton.classList.add("copied");
    caButton.setAttribute("aria-live", "polite");
  } catch {
    caButton.textContent = "Copy failed";
  }

  window.setTimeout(() => {
    caButton.textContent = originalText;
    caButton.classList.remove("copied");
  }, 1400);
});
