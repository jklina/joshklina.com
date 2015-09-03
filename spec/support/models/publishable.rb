module Models
  module Publishable
    RSpec.shared_examples "a publishable" do
      describe "#css_classes" do
        it "returns 'not-published' if the publishable is not published" do
          publishable = build(described_class_to_sym, published: false)

          expect(publishable.css_classes).to eq("not-published")
        end

        it "returns 'published' if the publishable is published" do
          publishable = build(described_class_to_sym, published: true)

          expect(publishable.css_classes).to eq("published")
        end
      end

      describe "#published" do
        it "is false by default" do
          publishable = build(described_class_to_sym)

          expect(publishable.published?).to be_falsey
        end
      end

      describe ".sorted_by_published_date" do
        it "finds all the published publishables ordered by date with the tag" do
          tagged_older_publishable = create(described_class_to_sym,
                                            published: true)
          tagged_newer_publishable = create(described_class_to_sym,
                                            published: true)

          tagged_older_publishable.published_at = Date.today - 2.days
          tagged_newer_publishable.published_at = Date.today
          tagged_older_publishable.save!
          tagged_newer_publishable.save!

          expect(described_class.sorted_by_published_date).
            to eq([tagged_newer_publishable, tagged_older_publishable])
        end
      end

      describe ".published" do
        it "returns only published publishables" do
          published_publishable = create(described_class_to_sym,
                                         published: true)
          unpublished_publishable = create(described_class_to_sym,
                                           published: false)

          expect(described_class.published).to eq([published_publishable])
        end
      end

      describe "#published_at" do
        it "is null by default" do
          publishable = build(described_class_to_sym)

          expect(publishable.published_at).to be_nil
        end

        it "is set to the current date when the publishable is published" do
          publishable = create(described_class_to_sym)

          publishable.published = true
          publishable.save!

          expect(publishable.published_at).to eq(Date.today)
        end

        it "only updates when the published attribute changes" do
          publishable = create(described_class_to_sym, published: true)

          publishable.published_at = Date.today - 1.day
          publishable.save!

          publishable.published = true
          publishable.save!

          expect(publishable.published_at).to eq(Date.today - 1.day)
        end
      end

      def described_class_to_sym
        described_class.name.underscore.to_sym
      end
    end
  end
end

