var express = require('express');
var router = express.Router();
const http = require('http').Server(express)
const io = require('socket.io')(http)

http.listen(9000, function() {
  console.log('Listeneing on *:9000')
})

// namespace
const cardCompare = io.of('/cardCompare')
const indianHoldem = io.of('/indianHoldem')
const blackAndWhite = io.of('/blackAndWhite')

// MARK: Card Compare
// 변수
const cardCompareRoom = 'cardCompareRoom'
const cardCompareUsers = {
  'user1': 'USER 1',
  'user2': 'USER 2'
}

// 소켓 명령어
cardCompare.on('connection', function(socket) {
  console.log('=== start card compare game ===')

  // Disconnect
  socket.on('disconnect', function() {
    socket.disconnect()
    cardCompareUsers['user1'] = 'USER 1'
    cardCompareUsers['user2'] = 'USER 2'
  })

  // Enter room
  socket.on('enter room', function(data) {
    const nickname = data['nickname']
    console.log(`${nickname} enter room`)
    socket.join(cardCompareRoom)
    if (cardCompareUsers['user1'] == 'USER 1') {
      cardCompareUsers['user1'] = nickname
    } else if (cardCompareUsers['user2'] == 'USER 2') {
      cardCompareUsers['user2'] = nickname
    } else {
      console.log('가득참')
    }
    cardCompare.to(cardCompareRoom).emit('room info', cardCompareUsers)
  })

  // Leave room
  socket.on('leave room', function(data) {
    const user = data['user']
    console.log(`${user} leave room`)
    socket.leave(cardCompareRoom)
    if (user == 'U1') {
      cardCompareUsers['user1'] = 'USER 1'
    } else {
      cardCompareUsers['user2'] = 'USER 2'
    }
    cardCompare.to(cardCompareRoom).emit('room info', cardCompareUsers)
  })

  // Deal
  socket.on('deal', function() {
    cardCompare.to(cardCompareRoom).emit('game info', {
      'user1SuitRandom': Math.floor(Math.random() * 4),
      'user1RankRandom': Math.floor(Math.random() * 13) + 1,
      'user2SuitRandom': Math.floor(Math.random() * 4),
      'user2RankRandom': Math.floor(Math.random() * 13) + 1,
    })
  })
})


// MARK: Black and White
// 변수
const blackAndWhiteRoom = 'blackAndWhiteRoom'
const blackAndWhiteUsers = {
  'isFull': false,
  'user1': '',
  'user2': ''
}

// 소켓 명령어
blackAndWhite.on('connection', function(socket) {
  console.log('=== start black and white game ===')

  // Disconnect
  socket.on('disconnect', function() {
    socket.disconnect()
    blackAndWhiteUsers['isFull'] = false
    blackAndWhiteUsers['user1'] = ''
    blackAndWhiteUsers['user2'] = ''
  })

  // Enter room
  socket.on('enter room', function(data) {
    const nickname = data['nickname']
    console.log(`${nickname} enter room`)
    socket.join(blackAndWhiteRoom)
    if (blackAndWhiteUsers['user1'] == '') {
      blackAndWhiteUsers['user1'] = nickname
    } else if (blackAndWhiteUsers['user2'] == '') {
      blackAndWhiteUsers['user2'] = nickname
    } else {
      console.log('가득참')
    }
    blackAndWhiteUsers['isFull'] = blackAndWhiteUsers['user1'] != '' && blackAndWhiteUsers['user2'] != ''
    blackAndWhite.to(blackAndWhiteRoom).emit('room info', blackAndWhiteUsers)
  })

  // Leave room
  socket.on('leave room', function(data) {
    const user = data['user']
    console.log(`${user} leave room`)
    socket.leave(blackAndWhiteRoom)
    if (user == 'U1') {
      blackAndWhiteUsers['user1'] = ''
    } else {
      blackAndWhiteUsers['user2'] = ''
    }
    blackAndWhiteUsers['isFull'] = false
    blackAndWhite.to(blackAndWhiteRoom).emit('room info', blackAndWhiteUsers)
  })

  // Select card
  socket.on('select card', function(data) {
    console.log(data)
    blackAndWhite.to(blackAndWhiteRoom).emit('game info', {
      'type': 'select card',
      'user': data.user,
      'rank': data.rank,
      'suit': data.suit
    })
  })

  // Deal
  socket.on('deal', function(data) {
    console.log(data)
    const playerRank = Number(data.player)
    const otherRank = Number(data.other)
    var result = "draw"
    if (playerRank > otherRank) {
      result = "user1"
    } else if (playerRank < otherRank) {
      result = "user2"
    }
    blackAndWhite.to(blackAndWhiteRoom).emit('game info', {
      'type': 'deal',
      'user': data.user,
      'result': result
    })
  })
})





// io.on('connection', function(socket) {
//   console.log('*** socket connected ***')

//   // Disconnect
//   socket.on('disconnect', function() { 
//     socket.disconnect();
//     for (i in roomList) {
//       const r = roomList[i]
//       r.user = []
//     }
//     console.log('*** socket disconnected ***'); 
//   })

//   // Enter room
//   socket.on('enter room', function(data) {
//     const room = data['room']
//     const nickname = data['nickname']
//     console.log(`${nickname} enter room at ${room}`)
//     console.log(data)
//     for (var i in roomList) {
//       const r = roomList[i]
//       if (r.name == room) {
//         if (r.user.length != 2) {
//           const nickname = data['nickname']
//           r.user.push(nickname)
//           socket.join(r.name)
//         }
//         io.to(room).emit('room info', {
//           'isFull': false,
//           'user': r.user
//         })
//         break
//       }
//     }
//   })

//   // Leave room
//   socket.on('leave room', function(data) {
//     const room = data['room']
//     const nickname = data['nickname']
//     console.log(`${nickname} leave room at ${room}`)
//     console.log(data)
//     for (var i in roomList) {
//       const r = roomList[i]
//       if (r.name == room) {
//         const idx = r.user.indexOf(nickname)
//         r.user.splice(idx, 1)
//         if (r.user.length != 0) {
//           io.to(room).emit('room info', {
//             'isFull': false,
//             'user': r.user
//           })
//         }
//         socket.leave(r.name)
//         break
//       }
//     }
//   })

//   // Deal
//   socket.on('deal', function(data) {
//     const room = data['room']
//     console.log(`deal room at ${room}`)
//     console.log(data)
//     io.to(room).emit('game info', {
//       'user1SuitRandom': Math.floor(Math.random() * 4),
//       'user1RankRandom': Math.floor(Math.random() * 13) + 1,
//       'user2SuitRandom': Math.floor(Math.random() * 4),
//       'user2RankRandom': Math.floor(Math.random() * 13) + 1,
//     })
//   })

// })

module.exports = router;
