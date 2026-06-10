export const Notifications = async ({ $ }) => {
  async function notify(title, message) {
    await $`notify-send ${title} ${message}`.quiet().nothrow();
    await $`canberra-gtk-play -i complete`.quiet().nothrow();
  }

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await notify("OpenCode", "Task finished.");
      }

      if (event.type === "permission.asked") {
        await notify("OpenCode", "Permission required.");
      }
    },
  };
};
