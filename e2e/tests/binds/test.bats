#!/usr/bin/env bats
#
# Copyright 2019 HAProxy Technologies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

load '../../libs/dataplaneapi'
load "../../libs/get_json_path"
load '../../libs/version'

@test "binds: setup" {
	run dpa_curl POST "/services/haproxy/configuration/frontends?force_reload=true&version=$(version)" "/frontends_post.json"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 201
}

@test "binds: Add a new bind" {
	run dpa_curl POST "/services/haproxy/configuration/binds?frontend=test_frontend&force_reload=true&version=$(version)" "../binds/post.json"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 201
}

@test "binds: Return one bind" {
	run dpa_curl GET "/services/haproxy/configuration/binds/test_bind?frontend=test_frontend"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 200

	local NAME; NAME=$(get_json_path "$BODY" '.data.name')
	[ "${NAME}" = "test_bind" ]
}

@test "binds: Replace a bind" {
	run dpa_curl PUT "/services/haproxy/configuration/binds/test_bind?frontend=test_frontend&force_reload=true&version=$(version)" "../binds/put.json"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 200
}

@test "binds: Return an array of binds" {
	run dpa_curl GET "/services/haproxy/configuration/binds?frontend=test_frontend"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 200

	local ACTUAL; ACTUAL=$(get_json_path "$BODY" '.data[0].name')
	[ "${ACTUAL}" = "test_bind" ]
}

@test "binds: Delete a bind" {
	run dpa_curl DELETE "/services/haproxy/configuration/binds/test_bind?frontend=test_frontend&force_reload=true&version=$(version)"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 204
}

@test "binds: teardown" {
	run dpa_curl DELETE "/services/haproxy/configuration/frontends/test_frontend?force_reload=true&version=$(version)"
	assert_success

	dpa_curl_status_body '$output'
	assert_equal $SC 204
}
