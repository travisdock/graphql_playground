member1 = Member.create(name: 'Billy', age: 27)
member2 = Member.create(name: 'Jerome', age: 33)
member3 = Member.create(name: 'Anastasia', age: 47)
club1 = Club.create(
  name: 'The Brave Explorers Club',
  founder: member3,
  description: 'A club for brave explorers only'
)
club1.members << member1
club1.members << member2
club1.members << member3