# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
variable "resource_group_name" {
  type = string
}

variable "environment" {
  type          = string
  description   = "Enviroment that the infrastructure code is deployed into"
}

variable "project" {
  type          = string
  description   = "Project that is running the infrastructure code"
}

variable "organisation" {
  type          = string
  description   = "Organisation that is running the infrastructure code"
}

variable "aggregations_domain_spn_object_id" {
  type          = string
  description   = "The object id of the aggregations domain service principal."
}

variable "charges_domain_spn_object_id" {
  type          = string
  description   = "The object id of the charges domain service principal."
}

variable "market_roles_domain_spn_object_id" {
  type          = string
  description   = "The object id of the market roles domain service principal."
}

variable "timeseries_domain_spn_object_id" {
  type          = string
  description   = "The object id of the time series domain service principal."
}

variable "metering_point_domain_spn_object_id" {
  type          = string
  description   = "The object id of the metering point domain service principal."
}

variable "post_office_domain_spn_object_id" {
  type          = string
  description   = "The object id of the post office domain service principal."
}

variable "validation_reports_domain_spn_object_id" {
  type          = string
  description   = "The object id of the validation reports domain service principal."
}