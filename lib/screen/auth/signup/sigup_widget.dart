import 'package:demo/constants/app_constant.dart';
import 'package:demo/constants/color_resources.dart';
import 'package:demo/provider/user_provider.dart';
import 'package:demo/utils/dimensions.dart';
import 'package:demo/utils/images.dart';
import 'package:demo/utils/styles.dart';
import 'package:demo/widgets/custom_auth_field.dart';
import 'package:demo/widgets/custom_drop_down.dart';
import 'package:demo/widgets/custom_methods.dart';
import 'package:flutter/Material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';


  Widget firstNameWidget(BuildContext context, firstNameController, focusNodeFirstName) {
    return AuthTextFormField(
      prefixIcon: getImage(Images.emailIcons,height: 18,width: 18),
      hintText: AppConstants.firstName,
      controller: firstNameController,
      focusNode: focusNodeFirstName,
      keyboardType: TextInputType.emailAddress,
      boxShadow: true,
      borderColor: ColorResources.grey,
      validator: (value) => value!.isEmpty ? 'Please enter your first name' : null,
    );
  }

  Widget phoneNumberWidget(BuildContext context, phoneController, focusNodePhone) {
    String completePhoneNumber = '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          focusNode: focusNodePhone,
          child: Builder(
            builder: (context) {
              return Container(
                width: getWidth(context),
                height: 60,
                padding: customPaddingOnly(bottom: 15,top: 15,left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorResources.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                      color: ColorResources.blackColor.withOpacity(0.1),
                    )
                  ],
                ),
                child: Center(
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    dropdownIcon: const Icon(Icons.keyboard_arrow_down_outlined,color: ColorResources.borderColor,),
                    dropdownIconPosition: IconPosition.trailing,
                    disableAutoFillHints: false,
                    autovalidateMode:AutovalidateMode.disabled,
                    // flagsButtonMargin: EdgeInsets.only(left: 15,top: 10),
                    dropdownTextStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: ColorResources.borderColor,
                    ),
                    cursorColor: ColorResources.primaryColor,
                    cursorHeight: 15,
                    controller: phoneController,
                    decoration:  InputDecoration(
                      contentPadding: EdgeInsets.only(top: 8,right: 20),
                      hintText: AppConstants.phoneNumber,
                      fillColor: ColorResources.borderColor,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontFamily: Dimensions.fontFamilyPoppins
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    languageCode: "IN",
                    initialCountryCode: 'IN',
                    showCountryFlag: false,
                    disableLengthCheck: false,

                    onChanged: (phone) {
                      final authProvider = Provider.of<UserProvider>(context, listen: false);
                      authProvider.phoneNumber = phone.completeNumber;
                      completePhoneNumber = phone.completeNumber;
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ${country.name}');
                    },
                  ),
                ),
              );
            },
          ),
        ),

      ],
    );
  }

  Widget emailWidget(BuildContext context, emailController, focusNodeEmail) {
    return AuthTextFormField(
      prefixIcon: getImage(Images.emailIcons,height: 18,width: 18),
      hintText: AppConstants.email,
      controller: emailController,
      focusNode: focusNodeEmail,
      keyboardType: TextInputType.emailAddress,
      boxShadow: true,
      borderColor: ColorResources.grey,
      validator: (value) => value!.isEmpty || !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value) ? 'Enter a valid email' : null,
    );
  }

  Widget passwordWidget(BuildContext context, UserProvider provider, passwordController,focusNodePassword) {
    return AuthTextFormField(
      prefixIcon: getImage(Images.passwordIcons, height: 18, width: 18),
      suffixIcon: IconButton(
        icon: Icon(
          provider.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: ColorResources.gray80,
        ),
        onPressed: provider.togglePasswordVisibility,
      ),
      hintText: "Enter Password",
      controller: passwordController,
      focusNode: focusNodePassword,
      obscureText: !provider.isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      boxShadow: true,
      maxLines: 1,
      borderColor: ColorResources.borderColor,
      validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
    );
  }

  Widget confirmPasswordWidget(BuildContext context, UserProvider provider,confirmPasswordController,passwordController,focusNodeConfirmPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextFormField(
          prefixIcon: getImage(Images.passwordIcons, height: 18, width: 18),
          suffixIcon: IconButton(
            icon: Icon(
              provider.isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: ColorResources.gray80,
            ),
            onPressed: provider.toggleConfirmPasswordVisibility,
          ),
          hintText: "Confirm Password",
          controller: confirmPasswordController,
          focusNode: focusNodeConfirmPassword,
          obscureText: !provider.isConfirmPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          boxShadow: true,
          borderColor: ColorResources.borderColor,
          validator: (value) => value != passwordController.text ? 'Passwords do not match' : null,
          maxLines: 1,
          onChanged: (_) => provider.validatePasswords(passwordController,confirmPasswordController),
        ),
        if (provider.passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Text(
              provider.passwordError!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget selectGenderWidget(BuildContext context, UserProvider provider) {
    return CustomDropDown(
      buttonWidth: getWidth(context, width: 1.0),
      buttonHeight: 58,

      borderRadius: BorderRadius.circular(12),
      items: ["Male", "Female", "Other"], // Gender options
      selectedValue: provider.selectGender,
      hintText: "Select Gender",
      hintTextStyle: textMd.copyWith(
        fontWeight: FontWeight.w400,
        color: ColorResources.blackColor,
      ),
      itemTextStyle: textMd.copyWith(
        fontWeight: FontWeight.w400,
        color: ColorResources.blackColor,
      ),

      onChanged: (value) {
        if (value != null) {
          provider.setGender(value);
        }
      },

    );
  }
