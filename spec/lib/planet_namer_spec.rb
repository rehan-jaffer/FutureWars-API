describe PlanetNamer do
  context 'generate all' do
    subject(:names) { PlanetNamer.generate_all }

    it 'returns a list of names' do
      expect(names.class).to be Array
      expect(names.size).to be > 1
      expect(names.size).to be names.uniq.size
    end
  end

  context 'generate one' do
    subject(:name) { PlanetNamer.generate_one }

    it 'generates a name' do
      expect(name).not_to be nil
      expect(name.size).to be > 0
      expect(name).to match(/^[a-zA-Z0-9 ]+$/)
    end
  end
end
