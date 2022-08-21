require_relative "../lib/belts_cli"

RSpec.describe BeltsCli do
  it "generates an executable project" do
    described_class.start(["new", "new_game"])

    game_id = fork do
      Dir.chdir("new_game") do
        described_class.start(["start"])
      end
    end

    sleep 3

    expect(Process.kill(15, game_id)).to equal(1)
  end
end
