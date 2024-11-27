part of 'pages.dart';

class OngkirPage extends StatefulWidget {
  const OngkirPage({super.key});

  @override
  State<OngkirPage> createState() => _OngkirPageState();
}

class _OngkirPageState extends State<OngkirPage> {
  final HomeViewModel homeViewmodel = HomeViewModel();

  dynamic selectedProvinceOrigin;
  dynamic selectedCityOrigin;
  dynamic selectedProvinceDest;
  dynamic selectedCityDest;
  dynamic selectedCourier;
  dynamic weight;

  @override
  void initState() {
    super.initState();
    homeViewmodel.getProvinceList();
  }

  bool get isFormValid {
    return selectedProvinceOrigin != null &&
        selectedCityOrigin != null &&
        selectedProvinceDest != null &&
        selectedCityDest != null &&
        selectedCourier != null &&
        weight != null &&
        weight.toString().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Calculate Cost"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewmodel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kurir",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DropdownButton(
                  value: selectedCourier,
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  elevation: 2,
                  hint: Text('Pilih kurir'),
                  style: TextStyle(color: Colors.black),
                  items: const [
                    DropdownMenuItem(value: 'jne', child: Text("JNE")),
                    DropdownMenuItem(value: 'pos', child: Text("POS")),
                    DropdownMenuItem(value: 'tiki', child: Text("TIKI")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedCourier = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Berat Paket",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: weight,
                  decoration: const InputDecoration(
                    labelText: "Berat (gr)",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    weight = value;
                  },
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Origin",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return Container(); 
                            case Status.error:
                              return Center(
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                value: selectedProvinceOrigin,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 2,
                                hint: Text('Pilih provinsi asal'),
                                style: TextStyle(color: Colors.black),
                                items: value.provinceList.data!
                                    .map<DropdownMenuItem<Province>>(
                                        (Province value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.province.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProvinceOrigin = newValue;
                                    selectedCityOrigin = null;
                                    homeViewmodel.getCityListForOrigin(
                                        selectedProvinceOrigin.provinceId);
                                  });
                                },
                              );
                            default:
                          }
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.cityListOrigin.status) {
                            case Status.loading:
                              return Container(); 
                            case Status.error:
                              return Center(
                                child: Text(
                                    value.cityListOrigin.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                value: selectedCityOrigin,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 2,
                                hint: Text('Pilih kota asal'),
                                style: TextStyle(color: Colors.black),
                                items: value.cityListOrigin.data!
                                    .map<DropdownMenuItem<City>>((City value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.cityName.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCityOrigin = newValue;
                                  });
                                },
                              );
                            default:
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Destination",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.provinceList.status) {
                            case Status.loading:
                              return Container(); 
                            case Status.error:
                              return Center(
                                child:
                                    Text(value.provinceList.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                value: selectedProvinceDest,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 2,
                                hint: Text('Pilih provinsi tujuan'),
                                style: TextStyle(color: Colors.black),
                                items: value.provinceList.data!
                                    .map<DropdownMenuItem<Province>>(
                                        (Province value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.province.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedProvinceDest = newValue;
                                    selectedCityDest = null;
                                    homeViewmodel.getCityListForDest(
                                        selectedProvinceDest.provinceId);
                                  });
                                },
                              );
                            default:
                          }
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Consumer<HomeViewModel>(
                        builder: (context, value, _) {
                          switch (value.cityListDest.status) {
                            case Status.loading:
                              return Container(); 
                            case Status.error:
                              return Center(
                                child:
                                    Text(value.cityListDest.message.toString()),
                              );
                            case Status.completed:
                              return DropdownButton(
                                value: selectedCityDest,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 2,
                                hint: Text('Pilih kota tujuan'),
                                style: TextStyle(color: Colors.black),
                                items: value.cityListDest.data!
                                    .map<DropdownMenuItem<City>>((City value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value.cityName.toString()),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCityDest = newValue;
                                  });
                                },
                              );
                            default:
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: isFormValid
                        ? () {
                            homeViewmodel.getOngkirList(
                                selectedCityOrigin.cityId,
                                selectedCityDest.cityId,
                                int.parse(weight),
                                selectedCourier);
                          }
                        : null,
                    child: const Text("Hitung Ongkir"),
                  ),
                ),
                const SizedBox(height: 24),
                Consumer<HomeViewModel>(
                  builder: (context, value, _) {
                    switch (value.ongkirList.status) {
                      case Status.loading:
                        return Container(); 
                      case Status.error:
                        return Center(
                          child: Text(value.ongkirList.message.toString()),
                        );
                      case Status.completed:
                        final ongkirData = value.ongkirList.data![0].costs!;
                        return Column(
                          children: ongkirData.map((ongkir) {
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    ongkir.service
                                            ?.toUpperCase()
                                            .substring(0, 1) ??
                                        "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                title: Text(
                                  "${ongkir.description ?? "Deskripsi tidak tersedia"} (${ongkir.service ?? "Nama Layanan"})",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: ongkir.cost?.map((cost) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              "Biaya: Rp${cost.value}",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            const SizedBox(
                                                height:
                                                    8),
                                            RichText(
                                              text: TextSpan(
                                                text:
                                                    "Estimasi sampai: ${cost.etd} hari",
                                                style: const TextStyle(
                                                  color: Colors
                                                      .green,
                                                  fontSize:
                                                      14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList() ??
                                      [],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
