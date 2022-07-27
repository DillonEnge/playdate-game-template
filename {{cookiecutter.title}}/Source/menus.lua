Menu = {}
Menu.__index = Menu
Menu.HORIZONTAL = 0
Menu.VERTICAL = 1

-- Menu is a generic 1D menu object which provides
-- an intuitive wrapper for playdate.ui.gridview
function Menu:new(
    x, y,
    width, height,
    contentInsetTable,
    cellPaddingTable,
    changeRowOnColumnWrap,
    menuOptions,
    backgroundImage,
    orientation
)
    local rowCount = 1
    local colCount = 1
    local sectionHeaderHeight = 0

    if orientation == self.HORIZONTAL then
        colCount = #menuOptions
    else
        rowCount = #menuOptions
    end

    self = playdate.ui.gridview.new(
        width / colCount,
        height / rowCount
    )
    self.menuOptions = menuOptions
    self.orientation = orientation
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.backgroundImage = backgroundImage

    self:setNumberOfRows(rowCount) -- number of sections is set automatically
    self:setNumberOfColumns(colCount)
    self:setSectionHeaderHeight(sectionHeaderHeight)

    if contentInsetTable then
        self:setContentInset(table.unpack(contentInsetTable))
    end

    if cellPaddingTable then
        self.cellPaddingTable = cellPaddingTable
    else
        self.cellPaddingTable = { 0, 0, 0, 0 }
    end

    self.changeRowOnColumnWrap = changeRowOnColumnWrap

    function self:drawCell(section, row, column, selected, x, y, width, height)
        local leftPad, rightPad, topPad, bottomPad = table.unpack(self.cellPaddingTable)
        local borderWidth = 4
        local rX, rY, rWidth, rHeight = table.unpack({
            x + leftPad, y + topPad,
            width - leftPad - rightPad, height - topPad - bottomPad
        })

        local fontHeight = Gfx.getFont():getHeight()


        local label = nil

        if self.orientation == Menu.HORIZONTAL then
            label = string.upper(self.menuOptions[column])
        else
            label = string.upper(self.menuOptions[row])
        end

        Gfx.setColor(Gfx.kColorBlack)
        Gfx.drawTextInRect(
            label,
            rX, rY + rHeight / 2 - fontHeight / 2,
            rWidth, fontHeight,
            nil, nil,
            kTextAlignment.center
        )

        if selected then
            Gfx.setColor(Gfx.kColorBlack)
            Gfx.setLineWidth(borderWidth)
            Gfx.drawRect(rX, rY, rWidth, rHeight)
        end
    end

    function self:getOptionAtSelected()
        local _, row, col = self:getSelection()

        if self.orientation == Menu.HORIZONTAL then
            return self.menuOptions[col]
        else
            return self.menuOptions[row]
        end
    end

    function self:selectNext(wrapSelection)
        if self.orientation == Menu.HORIZONTAL then
            self:selectNextColumn(wrapSelection)
        else
            self:selectNextRow(wrapSelection)
        end
    end

    function self:selectPrevious(wrapSelection)
        if self.orientation == Menu.HORIZONTAL then
            self:selectPreviousColumn(wrapSelection)
        else
            self:selectPreviousRow(wrapSelection)
        end
    end

    function self:update()
        if self.needsDisplay == true then
            Gfx.setColor(Gfx.kColorWhite)
            Gfx.fillRect(self.x, self.y, self.width, self.height)
            self:drawInRect(self.x, self.y, self.width, self.height)
        end
    end

    return self
end
