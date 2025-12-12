document.querySelector("#forgotForm").addEventListener("submit", async (e) => {
    e.preventDefault();

    const email = document.querySelector("#email").value;

    const response = await fetch("http://localhost:3000/forgot-password", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email })
    });

    const data = await response.json();

    alert(data.message);
});
