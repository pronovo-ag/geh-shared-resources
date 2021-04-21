using System.IO;
using System.Linq;
using GreenEnergyHub.Conversion.CIM;
using GreenEnergyHub.Conversion.CIM.Json;
using Xunit;

namespace GreenEnergyHub.Shared.Tests
{
    public class JsonWriterFactoryTests
    {
        [Fact]
        public void JsonWriterFactory_should_resolve_writer_from_generic_type()
        {
            var writer = JsonWriterFactory.CreateWriter<RequestChangeOfPriceList>(Stream.Null);

            Assert.NotNull(writer);
        }

        [Fact]
        public void JsonWriterFactory_should_resolve_writer_from_payload_type()
        {
            var writer = JsonWriterFactory.CreateWriter(typeof(RequestChangeOfPriceList), Stream.Null);

            Assert.NotNull(writer);
        }

        [Fact]
        public void JsonWriterFactory_should_resolve_all_known_document_types()
        {
            var documentType = typeof(MktActivityRecord);
            var asm = documentType.Assembly;

            var documents = asm.GetTypes()
                .Where(documentType.IsAssignableFrom)
                .Where(cls => cls != documentType);

            Assert.All(documents, type => JsonWriterFactory.CreateWriter(type, Stream.Null));
        }
    }
}
