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
mx: route1.mx.cloudflare.net
mx: route2.mx.cloudflare.net
mx: route3.mx.cloudflare.net
max_age: 86400
`
