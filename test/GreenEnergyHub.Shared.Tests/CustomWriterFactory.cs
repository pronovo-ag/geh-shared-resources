// Copyright 2020 Energinet DataHub A/S
//
// Licensed under the Apache License, Version 2.0 (the "License2");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

using System;
using System.Collections.Generic;
using GreenEnergyHub.Conversion.CIM.Json;

namespace GreenEnergyHub.Shared.Tests
{
    public class CustomWriterFactory : JsonWriterFactory
    {
        private readonly Dictionary<Type, JsonPayloadWriter> _map;

        public CustomWriterFactory(Dictionary<Type, JsonPayloadWriter> map)
        {
            _map = map;
        }

        protected override JsonPayloadWriter ResolveWriter(Type payloadType)
        {
            return _map.ContainsKey(payloadType) ? _map[payloadType] : base.ResolveWriter(payloadType);
        }

        protected override bool CanResolveWriter(Type payloadType)
        {
            return _map.ContainsKey(payloadType) || base.CanResolveWriter(payloadType);
        }
    }
}
