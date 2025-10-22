lint:
	cargo clippy \
      -- \
      \
      -W clippy::all \
      -W clippy::pedantic \
      \
      -A clippy::module_inception \
      -A clippy::missing_panics_doc \
      -A clippy::missing_errors_doc \
      -A clippy::manual_assert \
      \
      -D warnings

test:
	cargo test --all
	cargo test --all --release

cleanup:
	echo cleanup
