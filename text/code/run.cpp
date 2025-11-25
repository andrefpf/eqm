template<typename PelType>
void JPLM4DTransformModeLightFieldCodec<PelType>::run() {
  const auto& coordinates_and_sizes = 
    get_block_coordinates_and_sizes();
  if (isParallel) {
    const auto& N = 
      transform_mode_configuration.get_number_of_threads();
    #pragma omp parallel for num_threads(N)
    for (auto&& [position, size, channel] : 
                     coordinates_and_sizes) {
      run_for_block_4d(channel, position, size); 
    }
  } else {
    for (auto&& [position, size, channel] : 
                     coordinates_and_sizes) {
      run_for_block_4d(channel, position, size); 
    }
  }
  //... other options; omitted for simplification
  finalization();
}