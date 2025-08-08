package f1

import (
	"nested/n/f2"
)

func F1() int {
	f2.F2()
	return 2 + 2
}
