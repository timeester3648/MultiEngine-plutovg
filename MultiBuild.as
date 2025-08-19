void main(MultiBuild::Workspace& workspace) {	
	auto project = workspace.create_project(".");
	auto properties = project.properties();

	project.name("plutovg");
	properties.binary_object_kind(MultiBuild::BinaryObjectKind::eStaticLib);
	project.license("./LICENSE");

	project.include_own_required_includes(true);
	project.add_required_project_include({
		"./include"
	});

	properties.files({
		"./include/*.h",
		"./source/*.h",
		"./source/*.c"
	});

	properties.defines({ 
		"PLUTOVG_BUILD",
		"PLUTOVG_BUILD_STATIC"
	});

	{
		MultiBuild::ScopedFilter _(project, "project.compiler:VisualCpp");
		properties.disable_warnings({ "4244", "4267", "4018", "4996" });
	}
}