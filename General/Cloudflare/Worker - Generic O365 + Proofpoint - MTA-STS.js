async function handleRequest(request) {
  const init = {
    headers: {
      'content-type': 'text/plain; charset=UTF-8',
      'X-Clacks-Overhead': 'GNU Terry Pratchett',
    },
  }
  return new Response(stsHTML, init)
}
addEventListener('fetch', event => {
  return event.respondWith(handleRequest(event.request))
})
const stsHTML = `version: STSv1
mode: enforce
mx: *.mail.protection.outlook.com
mx: mx2-eu1.ppe-hosted.com
mx: mx1-eu1.ppe-hosted.com
max_age: 86400
`
