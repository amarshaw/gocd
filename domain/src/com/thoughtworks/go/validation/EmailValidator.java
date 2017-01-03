/*************************GO-LICENSE-START*********************************
 * Copyright 2014 ThoughtWorks, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *************************GO-LICENSE-END***********************************/

package com.thoughtworks.go.validation;

import com.thoughtworks.go.domain.materials.ValidationBean;
import com.thoughtworks.go.util.StringUtil;

public class EmailValidator extends Validator<String> {

    public static final String EMAIL_ERROR_MESSAGE = "Invalid email address.";

    public EmailValidator() {
        super(EMAIL_ERROR_MESSAGE);
    }

    public ValidationBean validate(String address) {
        if(StringUtil.isBlank(address)){
            return ValidationBean.valid();
        }
        if (address.matches(".*@" + HostnameValidator.HOSTNAME_PATTERN)) {
            return ValidationBean.valid();
        }
        return ValidationBean.notValid(EMAIL_ERROR_MESSAGE);
    }
}