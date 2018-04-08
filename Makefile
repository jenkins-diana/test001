# gnu-nompi

TARGET = salmon.cpu
FC = gfortran
CC = gcc
FFLAGS = -O3 -fopenmp -Wall -cpp -ffree-form -ffree-line-length-none
CFLAGS = -O3 -fopenmp -Wall
LIBLAPACK = -llapack -lblas
MODULE_SWITCH = -J
COMM_SET = dummy
OBJDIR = build_temp

ifdef SIMD_SET
C_SRC_STENSIL_FILE = ARTED/stencil/C/$(SIMD_SET)/current.c \
	ARTED/stencil/C/$(SIMD_SET)/hpsi.c \
	ARTED/stencil/C/$(SIMD_SET)/total_energy.c 
F_SRC_STENSIL_FILE =
else
C_SRC_STENSIL_FILE = 
F_SRC_STENSIL_FILE = ARTED/stencil/F90/current.f90 \
	ARTED/stencil/F90/hpsi.f90 \
	ARTED/stencil/F90/total_energy.f90
endif

ifdef COMM_SET
F_SRC_COMM_FILE = modules/salmon_communication_$(COMM_SET).f90
else
F_SRC_COMM_FILE = modules/salmon_communication.f90
endif


F_SRC_MODULE = $(F_SRC_COMM_FILE) \
	modules/salmon_file.f90 \
	modules/salmon_global.f90 \
	modules/salmon_math.f90 \
	modules/salmon_parallel.f90 \
	modules/inputoutput.f90

F_SRC_CORELIB = src/core/exc_cor.f90

F_SRC_ARTED = ARTED/common/Ylm_dYlm.f90 \
	ARTED/common/preprocessor.f90 \
	ARTED/modules/backup_routines.f90 \
	ARTED/modules/env_variables.f90 \
	ARTED/modules/global_variables.f90 \
	ARTED/modules/misc_routines.f90 \
	ARTED/modules/nvtx.f90 \
	ARTED/FDTD/beam.f90 \
	ARTED/GS/Density_Update.f90 \
	ARTED/GS/Fermi_Dirac_distribution.f90 \
	ARTED/GS/Occupation_Redistribution.f90 \
	ARTED/GS/io_gs_wfn_k.f90 \
	ARTED/GS/write_GS_data.f90 \
	ARTED/RT/Fourier_tr.f90 \
	ARTED/RT/init_Ac.f90 \
	ARTED/RT/k_shift_wf.f90 \
	ARTED/common/density_plot.f90 \
	ARTED/control/inputfile.f90 \
	ARTED/modules/opt_variables.f90 \
	ARTED/modules/timer.f90 \
	ARTED/preparation/fd_coef.f90 \
	ARTED/preparation/init.f90 \
	ARTED/preparation/init_wf.f90 \
	ARTED/preparation/input_ps.f90 \
	ARTED/preparation/prep_ps.f90 \
	ARTED/FDTD/FDTD.f90 \
	ARTED/GS/Gram_Schmidt.f90 \
	ARTED/RT/current.f90 \
	ARTED/RT/dt_evolve.f90 \
	ARTED/common/Exc_Cor.f90 \
	ARTED/common/Hartree.f90 \
	ARTED/common/hpsi.f90 \
	ARTED/common/ion_force.f90 \
	ARTED/common/psi_rho.f90 \
	ARTED/common/restart.f90 \
	ARTED/common/total_energy.f90 \
	ARTED/control/ground_state.f90 \
	ARTED/modules/performance_analyzer.f90 \
	$(F_SRC_STENSIL_FILE) \
	ARTED/GS/CG.f90 \
	ARTED/GS/diag.f90 \
	ARTED/GS/sp_energy.f90 \
	ARTED/RT/hamiltonian.f90 \
	ARTED/control/control_ms.f90 \
	ARTED/control/control_sc.f90 \
	ARTED/control/initialization.f90 \
	ARTED/main.f90

F_SRC_GCEED = GCEED/common/calc_iquotient.f90 \
	GCEED/common/calc_ob_num.f90 \
	GCEED/common/check_cep.f90 \
	GCEED/common/ylm.f90 \
	GCEED/gceed.f90 \
	GCEED/misc/setlg.f90 \
	GCEED/misc/setmg.f90 \
	GCEED/misc/setng.f90 \
	GCEED/modules/rmmdiis_eigen_lapack.f90 \
	GCEED/modules/scf_data.f90 \
	GCEED/read_input_gceed.f90 \
	GCEED/rt/check_ae_shape.f90 \
	GCEED/scf/check_dos_pdos.f90 \
	GCEED/common/allocate_sendrecv.f90 \
	GCEED/common/calc_Mps3rd.f90 \
	GCEED/common/check_mg.f90 \
	GCEED/common/check_ng.f90 \
	GCEED/common/conv_p.f90 \
	GCEED/common/conv_p0.f90 \
	GCEED/common/hartree.f90 \
	GCEED/common/init_wf.f90 \
	GCEED/common/laplacianh.f90 \
	GCEED/common/nabla.f90 \
	GCEED/common/read_copy_pot.f90 \
	GCEED/common/sendrecv_copy.f90 \
	GCEED/common/set_filename.f90 \
	GCEED/common/set_gridcoo.f90 \
	GCEED/common/set_icoo1d.f90 \
	GCEED/common/set_imesh_oddeven.f90 \
	GCEED/common/set_ispin.f90 \
	GCEED/common/setbN.f90 \
	GCEED/common/setcN.f90 \
	GCEED/common/writeavs.f90 \
	GCEED/common/writecube.f90 \
	GCEED/modules/allocate_mat.f90 \
	GCEED/modules/calc_invA_lapack.f90 \
	GCEED/modules/copyVlocal.f90 \
	GCEED/modules/new_world.f90 \
	GCEED/modules/read_pslfile.f90 \
	GCEED/modules/sendrecv_groupob_ngp.f90 \
	GCEED/rt/add_polynomial.f90 \
	GCEED/rt/calcVbox.f90 \
	GCEED/rt/calc_env_trigon.f90 \
	GCEED/rt/gradient_ex.f90 \
	GCEED/rt/taylor_coe.f90 \
	GCEED/scf/add_in_broyden.f90 \
	GCEED/scf/broyden.f90 \
	GCEED/scf/calc_occupation.f90 \
	GCEED/scf/calc_rho_in.f90 \
	GCEED/scf/copy_density.f90 \
	GCEED/scf/deallocate_sendrecv.f90 \
	GCEED/scf/eigen_subdiag_lapack.f90 \
	GCEED/scf/prep_ini.f90 \
	GCEED/scf/simple_mixing.f90 \
	GCEED/scf/structure_opt.f90 \
	GCEED/scf/subdgemm_lapack.f90 \
	GCEED/common/calc_allob.f90 \
	GCEED/common/calc_force.f90 \
	GCEED/common/calc_force_c.f90 \
	GCEED/common/calc_iroot.f90 \
	GCEED/common/calc_myob.f90 \
	GCEED/common/calc_pmax.f90 \
	GCEED/common/check_corrkob.f90 \
	GCEED/common/check_numcpu.f90 \
	GCEED/common/conv_core_exc_cor.f90 \
	GCEED/common/inner_product3.f90 \
	GCEED/common/inner_product4.f90 \
	GCEED/common/set_isstaend.f90 \
	GCEED/common/writedns.f90 \
	GCEED/common/writeelf.f90 \
	GCEED/common/writeestatic.f90 \
	GCEED/common/writepsi.f90 \
	GCEED/common/xc.f90 \
	GCEED/modules/allocate_psl.f90 \
	GCEED/modules/calc_density.f90 \
	GCEED/modules/change_order.f90 \
	GCEED/modules/copy_psi_mesh.f90 \
	GCEED/modules/deallocate_mat.f90 \
	GCEED/modules/init_sendrecv.f90 \
	GCEED/modules/inner_product.f90 \
	GCEED/modules/readbox_rt.f90 \
	GCEED/modules/writebox_rt.f90 \
	GCEED/rt/convert_input_rt.f90 \
	GCEED/rt/dip.f90 \
	GCEED/rt/projection.f90 \
	GCEED/rt/set_numcpu_rt.f90 \
	GCEED/rt/time_evolution_step.f90 \
	GCEED/rt/xc_fast.f90 \
	GCEED/scf/convert_input_scf.f90 \
	GCEED/scf/gram_schmidt.f90 \
	GCEED/scf/set_numcpu_scf.f90 \
	GCEED/common/OUT_IN_data.f90 \
	GCEED/common/bisection.f90 \
	GCEED/common/calcJxyz.f90 \
	GCEED/common/calcJxyz2nd.f90 \
	GCEED/common/calcVpsl.f90 \
	GCEED/common/calcuV.f90 \
	GCEED/common/psl.f90 \
	GCEED/common/storevpp.f90 \
	GCEED/modules/sendrecv.f90 \
	GCEED/modules/sendrecv_groupob.f90 \
	GCEED/modules/sendrecvh.f90 \
	GCEED/rt/read_rt.f90 \
	GCEED/rt/taylor.f90 \
	GCEED/rt/total_energy_groupob.f90 \
	GCEED/scf/calc_dos.f90 \
	GCEED/scf/calc_pdos.f90 \
	GCEED/scf/rmmdiis_eigen.f90 \
	GCEED/common/calc_gradient_fast.f90 \
	GCEED/common/calc_gradient_fast_c.f90 \
	GCEED/common/hartree_boundary.f90 \
	GCEED/common/hartree_cg.f90 \
	GCEED/modules/gradient2.f90 \
	GCEED/modules/laplacian2.f90 \
	GCEED/rt/calcEstatic.f90 \
	GCEED/modules/gradient.f90 \
	GCEED/modules/hpsi2.f90 \
	GCEED/rt/hpsi_groupob.f90 \
	GCEED/common/calcELF.f90 \
	GCEED/modules/total_energy.f90 \
	GCEED/scf/rmmdiis.f90 \
	GCEED/scf/subspace_diag.f90 \
	GCEED/scf/ybcg.f90 \
	GCEED/rt/real_time_dft.f90 \
	GCEED/scf/real_space_dft.f90

F_SRC_SALMON = main/main.f90

F_SRCS = $(F_SRC_MODULE) $(F_SRC_CORELIB) $(F_SRC_ARTED) $(F_SRC_GCEED) $(F_SRC_SALMON)
F_OBJS = $(addprefix $(OBJDIR)/,$(F_SRCS:.f90=.o))

C_SRCS = $(C_SRC_STENSIL_FILE) ARTED/modules/env_variables_internal.c 
C_OBJS = $(addprefix $(OBJDIR)/,$(C_SRCS:.c=.o))

SRCS = $(F_SRCS) $(C_SRCS)
OBJS = $(F_OBJS) $(C_OBJS)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS) -I $(OBJDIR)  $(LIBLAPACK)

.SUFFIXES:
.SUFFIXES: .F .F90 .o

$(OBJS): $(SRCS)

$(OBJDIR)/%.o : %.f90
	@if [ ! -d $(dir $@) ]; then mkdir -p $(dir $@); fi
	$(FC) $(FFLAGS) $(MODULE_SWITCH) $(OBJDIR) -o $@ -c $<

$(OBJDIR)/%.o : %.c
	@if [ ! -d $(dir $@) ]; then mkdir -p $(dir $@); fi
	$(CC) $(CFLAGS) -o $@ -c $<
	
clean: 
	rm -f $(TARGET)
	rm -rf $(OBJDIR)/*