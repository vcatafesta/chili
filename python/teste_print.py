scores = [("Rodney Dangerfield", -1), ("Marlon Brando", 1), ("You", 100)]
for (name, score) in scores:
    print "Hello %s. Your score is % d" % (name, score)

# or some might find this even more readable
for (name, score) in scores:
    print "Hello %(nm)s. Your score is %(sc) d" % {"nm": name, "sc": score}

x = 3.75
print x
print "You have $%0.2f in your pocket" % (x)
print "You have $%f in your pocket" % (x)
print "You have $%10.1f in your pocket" % (x)
print "You have $%0.0f in your pocket" % (x)
print "You have $%d in your pocket" % (x)
print "You have $%02d in your pocket" % (x)
print "You have $%0.2f. If you spend $1.25, you will have $%0.2f left" % (x, x - 1.25)
