protocol SortOption: RawRepresentable, CaseIterable, Hashable where RawValue == String, AllCases: RandomAccessCollection {}
