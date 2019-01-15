class PageViewModel < ApplicationViewModel
  def preview_brands
    @preview_brands ||=
      begin
        brands = Brand.reorder(name: :asc).slice(0, number_items_preview_brands)
        BrandViewModel.wrap(brands, options)
      end
  end

  def preview_collections
    @preview_collections ||=
      begin
        collections = Collection.all.slice(0, number_items_preview_collections)
        CollectionViewModel.wrap(collections, options)
      end
  end

  private

    def number_items_preview_brands
      Rails.configuration.number_items_preview_brands
    end

    def number_items_preview_collections
      Rails.configuration.number_items_preview_collections
    end
end
