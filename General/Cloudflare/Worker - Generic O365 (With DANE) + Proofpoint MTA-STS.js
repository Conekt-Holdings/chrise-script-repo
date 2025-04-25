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
mx: *.a-v1.mx.microsoft
mx: *.b-v1.mx.microsoft
mx: *.c-v1.mx.microsoft
mx: *.d-v1.mx.microsoft
mx: *.e-v1.mx.microsoft
mx: *.f-v1.mx.microsoft
mx: *.g-v1.mx.microsoft
mx: *.h-v1.mx.microsoft
mx: *.i-v1.mx.microsoft
mx: *.j-v1.mx.microsoft
mx: *.k-v1.mx.microsoft
mx: *.l-v1.mx.microsoft
mx: *.m-v1.mx.microsoft
mx: *.n-v1.mx.microsoft
mx: *.o-v1.mx.microsoft
mx: *.p-v1.mx.microsoft
mx: *.q-v1.mx.microsoft
mx: *.r-v1.mx.microsoft
mx: *.s-v1.mx.microsoft
mx: *.t-v1.mx.microsoft
mx: *.u-v1.mx.microsoft
mx: *.v-v1.mx.microsoft
mx: *.w-v1.mx.microsoft
mx: *.x-v1.mx.microsoft
mx: *.y-v1.mx.microsoft
mx: *.z-v1.mx.microsoft
mx: mx1-eu1.ppe-hosted.com
mx: mx2-eu1.ppe-hosted.com
max_age: 604800
`
