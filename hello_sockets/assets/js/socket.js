import { Socket } from 'phoenix';

const socket = new Socket('/socket', {params: {token: window.userToken}});

socket.connect();


const channel = socket.channel('ping');

channel.join()
  .receive('ok', resp => {
    console.log('joined ping', resp);
  })
  .receive('error', resp => {
    console.log('Unable to join ping', resp);
  });


channel.push('ping')
  .receive('ok', resp => {
    console.log('receive', resp.ping);
  });

channel.push('pong')
  .receive('ok', resp => {
    console.log('wont happen');
  })
  .receive('error', resp => {
    console.error('wont happen yet');
  })
  .receive('timeout', resp => {
    console.log('pong message timeout', resp);
  });

channel.push('param_ping', { error: true })
  .receive('error', resp => {
    console.error('param_ping error: ', resp);
  })

channel.push('param_ping', { error: false, arr: [1, 2] })
  .receive('ok', resp => {
    console.log('param_ping ok:', resp);
  });

channel.on('send_ping', payload => {
  console.log('ping requested', payload);
  channel.push('ping')
    .receive('ok', resp => {
      console.log('ping:', resp.ping);
    })
});

channel.push('invalid')
  .receive('ok', resp => {
    console.log('wont happen');
  })
  .receive('error', resp => {
    console.error('wont happen');
  })
  .receive('timeout', resp => {
    console.error('invalid event timeout');
  })
