require 'spec_helper'

describe Delayed::Job do
  context '#execute_synchronously' do
    it 'true by default' do
      expect(subject.class.execute_synchronously?).to be true
    end
  end
  context 'default' do
    it 'executes a job synchronously' do
      expect_any_instance_of(Dummy).to receive(:do!).once
      Dummy.new.delay.do!
    end
    it 'warns' do
      expect_any_instance_of(Dummy).to receive(:do!) { fail 'foobar!' }
      expect(subject.class).to receive(:warn).with(/\[WARNING\] Dummy#do! - foobar!/)
      Dummy.new.delay.do!
    end
  end
  context 'asynchronously' do
    before do
      subject.class.execute_asynchronously!
    end
    it 'executes a job asynchronously' do
      expect_any_instance_of(Dummy).to_not receive(:do!)
      Dummy.new.delay.do!
    end
  end
end
