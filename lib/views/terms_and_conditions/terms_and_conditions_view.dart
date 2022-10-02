import 'package:doctr/views/terms_and_conditions/terms_and_conditions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TermsAndConditions
    extends ViewModelBuilderWidget<TermsAndConditionsViewModel> {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, TermsAndConditionsViewModel viewModel,
      Widget? child) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: viewModel.goBack, icon: const Icon(Icons.arrow_back)),
        title: const Text('Terms and Conditions'),
      ),
      //TODO: terms and conditions here
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              // Center(
              //     child: Text(
              //   'DISCLAIMER',
              //   style: TextStyle(fontSize: 25),
              // )),
              Center(
                child: Text(
                  'No advice',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                  'This app (“App)” provides only information, is not medical or treatment advice and may not be treated as such by the user. As such, this App may not be relied upon for the purposes of medical diagnosis or as a recommendation for medical care or treatment. The information on this App is not a substitute for professional medical advice, diagnosis or treatment. All content, including text, graphics, images and information, contained on or available through this App is for general information purposes only'),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                'Professional Medical Advice and Assistance',
                style: TextStyle(fontSize: 25),
              )),
              Text(
                  'You are strongly encouraged to confirm any information obtained from or through this App with your physician or another professional healthcare provider and to review all information regarding any medical condition or treatment with your physician or other a professional healthcare provider.'),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                'No Reliance',
                style: TextStyle(fontSize: 25),
              )),
              Text(
                  'YOU MUST NEVER RELY ON ANY INFORMATION OBTAINED USING THIS APP FOR ANY DIAGNOSIS OR RECOMMENDATION FOR MEDICAL TREATMENT. YOU MUST NEVER RELY ON THE INFORMATION RECEIVED FROM THIS APP AS ALTERNATIVE TO MEDICAL ADVICE FROM YOUR PHYSICIAN OR OTHER PROFESSIONAL HEALTHCARE PROVIDER.'),
              Text(
                  'YOU MUST NEVER DISREGARD PROFESSIONAL MEDICAL ADVICE OR DELAY SEEKING MEDICAL TREATMENT AS RESULT OF ANY INFORMATION YOU HAVE SEEN ON OR ACCESSED THROUGH THIS APP. IF YOU HAVE ANY SPECIFIC QUESTIONS ABOUT ANY MEDICAL MATTER YOU SHOULD CONSULT YOUR PHYSICIAN OR OTHER PROFESSIONAL HEALTHCARE PROVIDER. IF YOU THINK YOU MAY BE SUFFERING FROM ANY MEDICAL CONDITION YOU SHOULD SEEK IMMEDIATE MEDICAL ATTENTION.'),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                'No Warranty',
                style: TextStyle(fontSize: 25),
              )),
              Text(
                  'The information provided by this App is provided “as is” without any representations or warranties, express or implied. Doctr makes no representations or warranties in relation to the medical or other information in this App.'),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                'Doctr does not warrant that:',
                style: TextStyle(fontSize: 25),
              )),
              Text(
                  '- The information provided by this App will be constantly available, or available at all;or - The information provided by this App is complete, true, accurate, up-to-date, or non-misleading.'),
              Text(
                  'DOCTR IS NOT RESPONSIBLE OR LIABLE FOR ANY ADVICE, COURSE OF TREATMENT, DIAGNOSIS OR ANY OTHER INFORMATION, SERVICES OR PRODUCTS THAT YOU OBTAIN THROUGH THE USE OF THIS APP.'),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'By using the app and checking the checkbox you have acknowledged that:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Text(
                  '- YOU HAVE READ THE UNDERSTAND THIS MEDICAL DISCLAIMER.\n - YOU AGREE WITH THIS MEDICAL DISCLAIMER.\n- YOU AGREE TO BE LEGALLY BOUND BY THIS MEDICAL DISCLAIMER, WHICH SHALL TAKE EFFECT IMMEDIATELY UPON CLICKING THE CHECKBOX BELOW.'),
              Text(
                  'IF YOU DO NOT AGREE TO BE LEGALLY BOUND BY THIS MEDICAL DISCLAIMER, YOU MAY NOT ACCESS THE APP, REGISTER THE APP UNDER YOUR NAME, OR USE THE APP.')
            ],
          ),
        ),
      ),
    );
  }

  @override
  TermsAndConditionsViewModel viewModelBuilder(BuildContext context) =>
      TermsAndConditionsViewModel();
}
