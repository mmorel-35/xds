package go_build_test

import (
	"testing"

	_ "github.com/cncf/xds/xds/data/orca/v3"
	_ "github.com/cncf/xds/xds/service/orca/v3"
	_ "github.com/cncf/xds/xds/type/v3"

        // Old names for backward compatibility.
        // TODO(roth): Remove these once no one is using them anymore.
	_ "github.com/cncf/xds/udpa/data/orca/v1"
	_ "github.com/cncf/xds/udpa/service/orca/v1"
	_ "github.com/cncf/xds/udpa/type/v1"
)

func TestNoop(t *testing.T) {
	// Noop test that verifies the successful importation of xDS protos
}
