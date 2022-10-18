import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather_test/domain/entity/city.dart';

class CitySearchField extends StatefulWidget {
  const CitySearchField({
    required this.initVal,
    required this.pickCity,
    required this.suggestionsCallback,
    super.key,
  });

  final String initVal;

  final void Function(City) pickCity;
  final Future<List<City>> Function(String) suggestionsCallback;

  @override
  State<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  final TextEditingController controller = TextEditingController();
  List<City> citiesList = [];

  @override
  void initState() {
    controller.text = widget.initVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      suggestionsBoxVerticalOffset: 5,
      hideSuggestionsOnKeyboardHide: true,
      textFieldConfiguration: TextFieldConfiguration(
        onChanged: (value) => {},
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          hintText: 'Введите город',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      noItemsFoundBuilder: (context) {
        return const SizedBox.shrink();
      },
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        citiesList = await widget.suggestionsCallback(pattern);
        return citiesList;
      },
      itemBuilder: (context, suggestion) {
        return Text('${suggestion.name}, ${suggestion.state}');
      },
      onSuggestionSelected: (suggestion) {
        widget.pickCity(suggestion);
        controller.text = suggestion.name;
      },
    );
  }
}
