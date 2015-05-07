require 'spec_helper'
require 'filesize'
require 'bigdecimal'

describe Filesize do

  describe '::PREFIXES' do
    it 'are the SI prefixes' do
      expect(Filesize::PREFIXES).to eq Filesize::TYPE_PREFIXES[:SI]
    end
  end

  describe '::SI' do
    it 'has the right multiplier' do
      expect(Filesize::SI[:multiplier]).to eq 1000
    end

    it 'has the right prefixes' do
      expect(Filesize::SI[:prefixes]).to eq Filesize::TYPE_PREFIXES[:SI]
    end
  end

  describe '::BINARY' do
    it 'has the right multiplier' do
      expect(Filesize::BINARY[:multiplier]).to eq 1024
    end

    it 'has the right prefixes' do
      expect(Filesize::BINARY[:prefixes]).to eq Filesize::TYPE_PREFIXES[:BINARY]
    end
  end

  describe '.from' do
    context 'SI units' do
      it 'parses kilobytes' do
        expect(Filesize.from('1 kB').to).to eq 1000
      end

      it 'parses megabytes' do
        expect(Filesize.from('1 MB').to).to eq 1000 * 1000
      end
    end

    context 'BINARY units' do
      it 'parses kilobytes' do
        expect(Filesize.from('1 KiB').to).to eq 1024
      end

      it 'parses megabytes' do
        expect(Filesize.from('1 MiB').to).to eq 1024 * 1024
      end
    end
  end

  describe '#to_i' do
    it 'returns the bytes' do
      expect(Filesize.new(555).to_i).to eq 555
    end
  end

  describe '#to' do
    it 'returns the number of bytes (default)' do
      expect(Filesize.new(555).to).to eq 555
    end

    it 'returns the number for the specified unit (BINARY)' do
      expect(Filesize.new(1024).to('KiB')).to eq 1.00
    end

    it 'returns the number for the specified unit (SI)' do
      expect(Filesize.new(1000).to('kB')).to eq 1.00
    end
  end

  describe '#to_s' do
    it 'returns the number of bytes (default) with its unit' do
      expect(Filesize.new(555).to_s).to eq '555.00 B'
    end

    it 'returns the number of for the specified unit with its unit (BINARY)' do
      expect(Filesize.new(1024).to_s('KiB')).to eq '1.00 KiB'
    end

    it 'returns the number of for the specified unit with its unit (SI)' do
      expect(Filesize.new(1000).to_s('kB')).to eq '1.00 kB'
    end
  end

  describe '#pretty' do
    it 'returns the number of the most matching prefix with its unit (BINARY default)' do
      expect(Filesize.new(1024).pretty).to eq '1.00 KiB'
    end

    it 'returns the number of the most matching prefix with its unit (SI)' do
      expect(Filesize.new(1000, Filesize::SI).pretty).to eq '1.00 kB'
    end
  end

  describe '::Floppy' do
    it 'has the right size in bytes' do
      expect(Filesize::Floppy.to_i).to eq 1_509_376
    end
  end

  describe '#==' do
    context 'when comparing the same file sizes' do
      it 'should return true' do
        expect(Filesize.from('100 B') == Filesize.from('100 B')).to eq true
      end
    end

    context 'when comparing two different file sizes' do
      it 'should return false' do
        expect(Filesize.from('100 B') == Filesize.from('99 B')).to eq false
      end
    end
  end

  describe '#!=' do
    context 'when comparing two different file sizes' do
      it 'should return true' do
        expect(Filesize.from('100 B') != Filesize.from('99 B')).to eq true
      end

      context 'when comparing the same file sizes' do
        it 'should return false' do
          expect(Filesize.from('100 B') != Filesize.from('100 B')).to eq false
        end
      end
    end
  end

  describe '#>' do
    context 'when comparing two file sizes and the first is greater than the second' do
      it 'should return true' do
        expect(Filesize.from('100 B') > Filesize.from('99 B')).to eq true
      end
    end

    context 'when comparing the same file sizes' do
      it 'should return false' do
        expect(Filesize.from('100 B') > Filesize.from('100 B')).to eq false
      end
    end

    context 'when comparing two file sizes and the first is smaller than the second' do
      it 'should return false' do
        expect(Filesize.from('99 B') > Filesize.from('100 B')).to eq false
      end
    end
  end

  describe '#<' do
    context 'when comparing two file sizes and the second is greater than the first' do
      it 'should return true' do
        expect(Filesize.from('99 B') < Filesize.from('100 B')).to eq true
      end
    end

    context 'when comparing the same file sizes' do
      it 'should return false' do
        expect(Filesize.from('100 B') < Filesize.from('100 B')).to eq false
      end
    end

    context 'when comparing two file sizes and the second is smaller than the first' do
      it 'should return false' do
        expect(Filesize.from('100 B') < Filesize.from('99 B')).to eq false
      end
    end
  end

  describe '#<=' do
    context 'when comparing two file sizes and the second is greater than the first' do
      it 'should return true' do
        expect(Filesize.from('99 B') <= Filesize.from('100 B')).to eq true
      end
    end

    context 'when comparing the same file sizes' do
      it 'should return true' do
        expect(Filesize.from('100 B') <= Filesize.from('100 B')).to eq true
      end
    end

    context 'when comparing two file sizes and the first equals the second' do
      it 'should return true' do
        expect(Filesize.from('100 B') <= Filesize.from('100 B')).to eq true
      end
    end

    context 'when comparing two file sizes and the second is smaller than the first' do
      it 'should return false' do
        expect(Filesize.from('100 B') <= Filesize.from('99 B')).to eq false
      end
    end
  end

  describe '#>=' do
    context 'when comparing two file sizes and the first is greater than the second' do
      it 'should return true' do
        expect(Filesize.from('100 B') >= Filesize.from('99 B')).to eq true
      end
    end

    context 'when comparing the same file sizes' do
      it 'should return true' do
        expect(Filesize.from('100 B') >= Filesize.from('100 B')).to eq true
      end
    end

    context 'when comparing two file sizes and the first is smaller than the second' do
      it 'should return false' do
        expect(Filesize.from('99 B') >= Filesize.from('100 B')).to eq false
      end
    end
  end

  describe '::CD' do
    it 'has the right size in bytes' do
      expect(Filesize::CD.to_i).to eq 700_000_000
    end
  end

  describe '::DVD_5' do
    it 'has the right size in bytes' do
      expect(Filesize::DVD_5.to_i).to eq 4_702_989_189
    end
  end

  describe '::DVD' do
    it 'has the right size in bytes' do
      expect(Filesize::DVD.to_i).to eq 4_702_989_189
    end
  end

  describe '::DVD_9' do
    it 'has the right size in bytes' do
      expect(Filesize::DVD_9.to_i).to eq 8_504_035_246
    end
  end

  describe '::DVD_10' do
    it 'has the right size in bytes' do
      expect(Filesize::DVD_10.to_i).to eq 9_405_978_378
    end
  end

  describe '::DVD_14' do
    it 'has the right size in bytes' do
      expect(Filesize::DVD_14.to_i).to eq 13_207_024_435
    end
  end

  describe '::DVD_18' do
    it 'has the right size in bytes' do
      expect(Filesize::DVD_18.to_i).to eq 26_414_048_870
    end
  end

  describe '::ZIP' do
    it 'has the right size in bytes' do
      expect(Filesize::ZIP.to_i).to eq 100_000_000
    end
  end
end
