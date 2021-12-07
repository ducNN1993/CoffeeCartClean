import 'package:coffeecarttest/domain/model/coffee_detail.dart';
import 'package:coffeecarttest/domain/model/coffee_extras.dart';
import 'package:coffeecarttest/domain/model/coffee_extras_items.dart';
import 'package:coffeecarttest/presentation/base/base_page_mixin.dart';
import 'package:coffeecarttest/presentation/base/index.dart';
import 'package:coffeecarttest/presentation/resources/index.dart';
import 'package:coffeecarttest/presentation/styles/index.dart';
import 'package:coffeecarttest/presentation/utils/index.dart';
import 'package:coffeecarttest/presentation/widgets/progress_hud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class CoffeeCartPage extends BasePage {
  CoffeeCartPage(PageTag tag) : super(tag: tag);

  @override
  State<StatefulWidget> createState() => CoffeeCartPageState();
}

class CoffeeCartPageState
    extends BasePageState<CoffeeCartBloc, CoffeeCartPage, CoffeeCartRouter> {
  CoffeeDetail? data;
  int _currentCount = 1;

  // key = extra_items.id
  // value = extra_items.extra_id
  Map<int, int> _selectedOption = {};

  @override
  void initState() {
    super.initState();
    bloc.dispatchEvent(InitDetailCoffeeEvent());
  }

  @override
  void stateListenerCallBack(BaseState state) {
    super.stateListenerCallBack(state);
    if (state is InitDetailCoffeeSuccessState) {
      data = state.r;
    } else if (state is InitDetailCoffeeFailureState) {
      showSnackBarMessage(AppLocalizations.shared.connectionError, context);
    }
  }

  @override
  Widget buildBody(BuildContext context, BaseBloc<BaseEvent, BaseState> bloc) {
    return Scaffold(
      body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            return ProgressHud(
              inAsyncCall: state is LoadingState,
              child: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    bloc.dispatchEvent(InitDetailCoffeeEvent());
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _buildTopBanner(imageUrl: data?.images?.fullSize),
                        _buildDescriptions(
                            name: data?.name,
                            fullDescription: data?.fullDescription),
                        _buildQuantitySection(),
                        _buildOptionList(
                            extras: data?.extraItems,
                            extrasOption: data?.extras),
                        _buildFloatingCartButton()
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  _buildTopBanner({String? imageUrl}) {
    return Stack(
      children: [
        imageUrl != null
            ? Image.network(
                imageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Container();
                },
              )
            : Container(),
        ElevatedButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            // navigator.popBack(context: context);
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: const EdgeInsets.all(5),
              onSurface: Colors.black,
              primary: Colors.white),
        ),
      ],
    );
  }

  /// get total price
  _getTotalPrice() {
    int priceForEachCup = data?.price ?? 0;
    _selectedOption.forEach((key, value) {
      /// get price for each cup
      priceForEachCup += data?.extraItems
              ?.firstWhere((element) => element?.id == key)
              ?.priceNum ??
          0;
    });
    return _currentCount * priceForEachCup;
  }

  _buildQuantitySection() {
    final total = _getTotalPrice();
    final disableColor = Colors.grey;
    final defaultColor = Colors.brown;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '\$ $total',
            style: getTextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Spacer(),
          ElevatedButton(
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              if (_currentCount > 1) {
                setState(() {
                  _currentCount--;
                });
              }
            },
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: const EdgeInsets.all(5),
                primary: _currentCount > 1 ? defaultColor : disableColor),
          ),
          const SizedBox(
            width: 10,
          ),
          Text('$_currentCount'),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _currentCount++;
              });
            },
            style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: const EdgeInsets.all(5),
                primary: defaultColor),
          )
        ],
      ),
    );
  }

  /// build list of option
  _buildOptionList({
    List<CoffeeExtraItems?>? extras,
    List<CoffeeExtras>? extrasOption,
  }) {
    return extrasOption != null && extrasOption.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildOptionSection(
                  option: extrasOption[index],
                  items: extras
                      ?.where((e) => e?.extraId == extrasOption[index].id)
                      .toList());
            },
            itemCount: extrasOption.length,
          )
        : Container();
    ;
  }

  _buildFloatingCartButton() {
    final total = _getTotalPrice();
    return Material(
      child: InkWell(
        onTap: () {
          showSnackBarMessage(
              "${AppLocalizations.shared.total}: $total", context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.brown,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              Spacer(),
              Text(
                AppLocalizations.shared.addItemToCart,
                style: getTextStyle(),
              ),
              Spacer(),
              Expanded(
                  child: Text(
                '\$$total',
                style: getTextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
      ),
    );
  }

  _buildDescriptions({String? name, String? fullDescription}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          name ?? '',
          style: getTextStyle(color: Colors.black, fontSize: 25),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          fullDescription ?? '',
          style:
              getTextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30,
        ),
        buildDivider()
      ],
    );
  }

  /// build choice from option
  _buildIExtrasItem({
    CoffeeExtraItems? extra,
    required int index,
    required CoffeeExtras option,
  }) {
    String price = "";
    if (extra != null && extra.price != null && extra.priceNum != 0) {
      price = "(\$${extra.price})";
    }
    final multipleChoice = option.maxNum > 1;
    final isRequire = option.minNum > 0;
    final extraId = extra?.extraId ?? -1;
    final id = extra?.id ?? -1;
    // add default item
    if (index == 0 && !_selectedOption.containsValue(extraId) && isRequire) {
      _selectedOption.putIfAbsent(id, () => extraId);
    }
    final groupId = _selectedOption.containsKey(id) ? id : -1;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Text(
            extra?.name ?? "",
            style:
                getTextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          Text(
            " $price",
            style:
                getTextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          Spacer(),
          option.maxNum > 0
              ? Radio(
                  value: id,
                  toggleable: multipleChoice,
                  visualDensity: VisualDensity.compact,
                  groupValue: groupId,
                  onChanged: (value) {
                    setState(() {
                      int optionSelectedCount = _selectedOption.values
                          .where((el) => el == extraId)
                          .length;

                      /// if already chosen option
                      if (_selectedOption.containsKey(id)) {
                        if (!isRequire) {
                          _selectedOption.remove(id);
                        } else {
                          // if this section require
                          // this section must have at least 1 option
                          // count all option chosen from this section

                          // more than 1 option => can remove
                          if (optionSelectedCount > 1) {
                            _selectedOption.remove(id);
                          }
                        }
                      }

                      /// if did not choose option
                      else {
                        // multiple choice and < max => add option
                        if (multipleChoice &&
                            optionSelectedCount <= option.maxNum) {
                          _selectedOption.putIfAbsent(id, () => extraId);
                        } else {
                          // if not multiple choice remove other
                          if (_selectedOption
                              .containsValue(extra?.extraId ?? -1)) {
                            _selectedOption
                                .removeWhere((key, value) => value == extraId);
                          }
                          // add new
                          _selectedOption.putIfAbsent(id, () => extraId);
                        }
                      }
                    });
                  },
                )
              : Container()
        ],
      ),
    );
  }

  /// build option section (eg : milk option)
  _buildOptionSection(
      {required CoffeeExtras option, List<CoffeeExtraItems?>? items}) {
    return Column(
      children: [
        Container(
            color: Colors.grey.withOpacity(0.3),
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
            child: Row(
              children: [
                Text(
                  '${option.name}  ',
                  style: getTextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Text(
                  option.minNum > 0 ? AppLocalizations.shared.required : '',
                  style: getTextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                ),
              ],
            )),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
          color: Colors.grey,
          child: Text(
            AppLocalizations.shared.selectItem,
            style: getTextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        items != null && items.isNotEmpty
            ? ListView.separated(
                itemBuilder: (_, index) => _buildIExtrasItem(
                    extra: items[index], index: index, option: option),
                physics: NeverScrollableScrollPhysics(),
                itemCount: items.length,
                shrinkWrap: true,
                separatorBuilder: (_, index) => buildDivider())
            : Container(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
