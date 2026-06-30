import { defineConfig } from 'vitepress'

export default defineConfig({
  base: '/support/',
  title: "AuraTrace Help",
  description: "Help and Support page for AuraTrace",

  assetsDir: 'support-assets',

  // Keep this for Nginx safety
  vite: {
    build: {
      // assetsDir moved to root
    }
  },

  themeConfig: {
    search: { provider: 'local' },

    // Top Navigation Bar
    nav: [
      { text: 'Help Center', link: '/help-and-support/' }, // Goes to help/index.md
      { text: 'Release Notes', link: '/release-notes/' } // Goes to release-notes/index.md
    ],

    // Sidebar: USE AN OBJECT, NOT AN ARRAY
    sidebar: {
      // 1. Sidebar for Help Pages
      '/help-and-support/': [
        {
          text: 'Support Center',
          items: [
            // NOTICE: All links must have '/help-and-support/' prefix now
            { text: 'Help Home', link: '/help-and-support/' },
            { text: 'Login', link: '/help-and-support/login' },
            { text: 'Dashboard', link: '/help-and-support/dashboard' }, // Case sensitive! Match filename
            { text: 'Documents', link: '/help-and-support/documents' },
            { text: 'User Settings', link: '/help-and-support/user-settings' },
            { text: 'Learning', link: '/help-and-support/lms' },
            { text: 'Troubleshooting', link: '/help-and-support/troubleshooting' },
          ]
        }
      ],

      // 2. Sidebar for Release Notes (Separate)
      '/release-notes/': [
        {
          text: 'Releases',
          items: [
            { text: 'Latest Updates', link: '/release-notes/' }
          ]
        }
      ]
    },

    socialLinks: []
  }
})