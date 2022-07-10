-- whether we're automatically lightboxing
local auto = false

-- whether we need lightbox dependencies added
local needsLightbox = false

-- a counter used to ensure each image is in its own gallery
local imgCount = 0

-- attributes to forward from the image to the newly created link
local kForwardedAttr = {
  "title", "description", "desc-position", 
  "type", "effect", "width", "height", "zoomable", "draggable"
}

-- A list of images already within links that we can use to filter
local imagesWithinLinks = pandoc.List({})

return {
  {
    Meta = function(meta) 
      -- If the mode is auto, we need go ahead and 
      -- run if there are any images (ideally we would)
      -- filter to images in the body, but that can be
      -- left for future me to deal with 
      -- supports:
      -- lightbox: auto
      -- or
      -- lightbox:
      --   match: auto
      local lbMeta = meta.lightbox
      if lbMeta ~= nil and type(lbMeta) == 'table' then
        if lbMeta[1] ~= nil then
          if lbMeta[1].text == "auto" then
            auto = true
          end
        elseif lbMeta.match ~= nil and pandoc.utils.stringify(lbMeta.match) == 'auto' then
          auto = true
        end
      end
    end, 
    -- Find images that are already within links
    -- we'll use this to filter out these images if
    -- the most is auto
    Link = function(linkEl)
      pandoc.walk_inline(linkEl, {
        Image = function(imageEl) 
          imagesWithinLinks[#imagesWithinLinks + 1] = imageEl
        end
      })
    end
  },
  {
  Image = function(imgEl)
    if quarto.doc.isFormat("html:js") then
      local isAlreadyLinked = imagesWithinLinks:includes(imgEl)
      if (not isAlreadyLinked and auto) or imgEl.classes:includes('lightbox') then
        -- note that we need to include the dependency for lightbox
        needsLightbox = true
        imgCount = imgCount + 1

        -- remove the class from the image
        imgEl.attr.classes = imgEl.attr.classes:filter(function(clz) 
          return clz ~= 'lightbox'
        end)
        
        -- attributes for the link
        local linkAttributes = {}

        -- mark this image as a lightbox target
        linkAttributes.class = 'lightbox'

        -- get the alt text from image and use that as title
        local title = nil
        if imgEl.caption ~= nil and #imgEl.caption > 0 then
          linkAttributes.title = pandoc.utils.stringify(imgEl.caption)
        end

        -- move a group attribute to the link, if present
        if imgEl.attr.attributes.group ~= nil then
          linkAttributes.gallery = imgEl.attr.attributes.group
          imgEl.attr.attributes.group = nil
        else 
          linkAttributes.gallery = 'quarto-gallery-' .. imgCount
        end

        -- forward any other known attributes
        for i, v in ipairs(kForwardedAttr) do
          if imgEl.attr.attributes[v] ~= nil then
            -- forward the attribute
            linkAttributes[v] = imgEl.attr.attributes[v]

            -- clear the attribute
            imgEl.attr.attributes[v] = nil
          end
        end

        -- wrap decorated images in a link with appropriate attrs
        local link = pandoc.Link({imgEl}, imgEl.src, nil, linkAttributes)
        return link
      end
    end 
  end,
  Meta = function(meta)
    -- If we discovered lightbox-able images
    -- we need to include the dependencies
    if needsLightbox then
      -- add the dependency
      quarto.doc.addHtmlDependency({
        name = 'glightbox',
        scripts = {'resources/js/glightbox.min.js'},
        stylesheets = {'resources/css/glightbox.min.css'}
      })

      -- read lightbox options
      local lbMeta = meta.lightbox
      local lbOptions = {}
      local readEffect = function(el) 
        local val = pandoc.utils.stringify(el)
        if val == "fade" or val == "zoom" or val == "none" then
          return val
        else
          error("Invalid effect " + val)
        end
      end

      -- permitted options include:
      -- lightbox:
      --   effect: zoom | fade | none
      --   desc-position: top | bottom | left |right
      local effect = "zoom"
      local descPosition = "bottom" 
      
      -- The selector controls which elements are targeted.
      -- currently, it always targets .lightbox elements
      -- and there is no way for the user to change this
      local selector = ".lightbox"

      if lbMeta ~= nil and type(lbMeta) == 'table' then
        if lbMeta.effect ~= nil then
          effect = readEffect(lbMeta.effect)
        end

        if lbMeta['desc-position'] ~= nil then
          descPosition = pandoc.utils.stringify(lbMeta['desc-position'])
        end  
      end

      -- generate the initialization script with the correct options
      local scriptTag = "<script>var lightboxQuarto = GLightbox({selector: '" .. selector .. "', closeEffect: '" .. effect .. "', openEffect: '" .. effect .. "', descPosition: '" .. descPosition .. "' });</script>"

      -- inject the rendering code
      quarto.doc.includeText("after-body", scriptTag)

    end
  end
}}
