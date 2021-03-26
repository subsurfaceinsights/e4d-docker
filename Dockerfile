
#build e4d
FROM ubuntu:20.04 as e4d-build
ARG PETSC_VERSION=v3.13.5
ARG E4D_VERSION=e37a32c
ARG E4D_REPO=https://github.com/subsurfaceinsights/E4D.git
WORKDIR /build
COPY ./ubuntu-e4d-build-deps.sh .
RUN ./ubuntu-e4d-build-deps.sh && rm -rf /var/lib/apt/lists/*
COPY ./build-petsc.sh .
RUN ./build-petsc.sh $PETSC_VERSION
COPY ./build-e4d.sh .
ENV PATH="/build/petsc/arch-linux-c-opt/bin:${PATH}"
ENV LD_LIBRARY_PATH="/build/petsc/arch-linux-c-opt/lib:${LD_LIBRARY_PATH}"
ENV C_INCLUDE_PATH="/build/petsc/arch-linux-c-opt/include:${C_INCLUDE_PATH}"
RUN ./build-e4d.sh $E4D_REPO $E4D_VERSION

FROM ubuntu:20.04 as e4d
COPY ./ubuntu-e4d-run-deps.sh .
RUN ./ubuntu-e4d-run-deps.sh && rm -rf /var/lib/apt/lists/*
COPY --from=e4d-build /build/E4D/bin/e4d /bin
COPY --from=e4d-build /build/E4D/bin/tetgen /bin
COPY --from=e4d-build /build/E4D/bin/triangle /bin
COPY --from=e4d-build /build/E4D/bin/px /bin
COPY --from=e4d-build /build/petsc/arch-linux-c-opt/share /build/petsc/arch-linux-c-opt/share
COPY --from=e4d-build /build/petsc/arch-linux-c-opt/lib /build/petsc/arch-linux-c-opt/lib
COPY --from=e4d-build /build/petsc/arch-linux-c-opt/bin /build/petsc/arch-linux-c-opt/bin
ENV PATH="/build/petsc/arch-linux-c-opt/bin:${PATH}"
ENV LD_LIBRARY_PATH="/build/petsc/arch-linux-c-opt/lib:${LD_LIBRARY_PATH}"
COPY docker-entrypoint.sh .
WORKDIR /data
ENTRYPOINT [ "../docker-entrypoint.sh" ]
