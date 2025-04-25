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
mx: ASPMX.L.GOOGLE.COM
mx: ALT1.ASPMX.L.GOOGLE.COM
mx: ALT2.ASPMX.L.GOOGLE.COM
mx: ALT3.ASPMX.L.GOOGLE.COM
mx: ALT4.ASPMX.L.GOOGLE.COM
mx: aspmx2.googlemail.com
mx: aspmx3.googlemail.com
max_age: 604800
`
