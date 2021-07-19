jQuery(document).ready(function() {
	let fuse = null;

	let elections_data = {};
	jQuery.get("/elections.json", function(data) {
		fuse = new Fuse(data, {
			minMatchCharLength: 3,
			keys: ["name"]
		});
	});

	jQuery("#sq").val("");
	jQuery("#sq").on("input", function(e) {
		let value = e.target.value;

		if (value == "") {
			jQuery(".no-search").removeClass("d-none");
			jQuery(".search").addClass("d-none");
			return;
		}

		let results = jQuery(".search .results");
		results.empty();

		let search_results = fuse.search(value)
		jQuery.each(search_results, function(i, entry) {
			el = jQuery(`<div class="col-md-6">
				<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
					<div class="col p-4 d-flex flex-column position-static">
						<a href="` + entry.item["path"] + `" class="stretched-link">
							<h3 class="mb-0">` + entry.item["name"] + `</h3>
						</a>
					</div>
				</div>
			</div>`);
			results.append(el);

			return i < 10;
		});

		jQuery(".no-search").addClass("d-none");
		jQuery(".search").removeClass("d-none");
	});
});
