"""xDS cc_test rules"""

def xds_cc_test(name, **kwargs):
    native.cc_test(
        name = name,
        **kwargs
    )

# Old name for backward compatibility.
# TODO(roth): Remove this once all callers are migrated to the new name.
def udpa_cc_test(name, **kwargs):
    xds_cc_test(name, **kwargs)
