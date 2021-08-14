Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 130293EC2FB
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Aug 2021 15:53:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gn22N6yRwz30J3
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Aug 2021 23:53:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gn22D6Cg4z309g
 for <linux-erofs@lists.ozlabs.org>; Sat, 14 Aug 2021 23:53:19 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="301268456"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; d="scan'208";a="301268456"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2021 06:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; d="scan'208";a="678161765"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
 by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2021 06:52:09 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mEu53-000Orn-1U; Sat, 14 Aug 2021 13:52:09 +0000
Date: Sat, 14 Aug 2021 21:51:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 d252ff3de786a28b1bedf4c03fb31d142d32219b
Message-ID: <6117ca6b.JxVHEoXDdWPbww0N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: d252ff3de786a28b1bedf4c03fb31d142d32219b  erofs: remove the mapping parameter from erofs_try_to_free_cached_page()

elapsed time: 4988m

configs tested: 420
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210814
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210813
arm                          pxa910_defconfig
arm                        oxnas_v6_defconfig
mips                           ci20_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                           rs90_defconfig
powerpc                     mpc5200_defconfig
parisc                              defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc8540_ads_defconfig
ia64                                defconfig
arm                       imx_v6_v7_defconfig
parisc                generic-32bit_defconfig
arm                     am200epdkit_defconfig
sh                           se7724_defconfig
sh                         microdev_defconfig
sh                           se7712_defconfig
sh                     sh7710voipgw_defconfig
sh                          polaris_defconfig
powerpc                      bamboo_defconfig
powerpc                       holly_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        cell_defconfig
powerpc                 mpc837x_rdb_defconfig
parisc                           alldefconfig
sh                ecovec24-romimage_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
powerpc                     redwood_defconfig
arm                         at91_dt_defconfig
sh                   secureedge5410_defconfig
powerpc                     pseries_defconfig
powerpc                      makalu_defconfig
arm                      jornada720_defconfig
mips                        workpad_defconfig
xtensa                  audio_kc705_defconfig
arc                     nsimosci_hs_defconfig
sh                        sh7757lcr_defconfig
mips                        bcm63xx_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arm                          ep93xx_defconfig
arm                          iop32x_defconfig
powerpc                    ge_imp3a_defconfig
arm                        spear6xx_defconfig
mips                            ar7_defconfig
arm                         palmz72_defconfig
xtensa                              defconfig
arm                       aspeed_g5_defconfig
mips                        omega2p_defconfig
powerpc                        warp_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  nommu_kc705_defconfig
ia64                             allmodconfig
m68k                             alldefconfig
sh                          rsk7264_defconfig
sh                            titan_defconfig
powerpc                     asp8347_defconfig
powerpc                        icon_defconfig
arc                          axs103_defconfig
mips                      pic32mzda_defconfig
nios2                            allyesconfig
riscv                    nommu_virt_defconfig
arm                      footbridge_defconfig
arm                         assabet_defconfig
arm                       aspeed_g4_defconfig
mips                        qi_lb60_defconfig
sh                              ul2_defconfig
sh                           se7619_defconfig
powerpc                      tqm8xx_defconfig
arm                         lpc18xx_defconfig
sh                        edosk7760_defconfig
x86_64                            allnoconfig
sh                             shx3_defconfig
mips                  maltasmvp_eva_defconfig
mips                         bigsur_defconfig
powerpc64                           defconfig
arm                     davinci_all_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
h8300                            alldefconfig
arm                        mvebu_v5_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7785lcr_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
arm                           u8500_defconfig
nios2                         3c120_defconfig
ia64                        generic_defconfig
powerpc                     tqm8555_defconfig
powerpc                      acadia_defconfig
arm                          simpad_defconfig
mips                     decstation_defconfig
mips                malta_qemu_32r6_defconfig
sh                          sdk7786_defconfig
powerpc                          g5_defconfig
riscv                             allnoconfig
nios2                            alldefconfig
arm                        vexpress_defconfig
mips                            gpr_defconfig
mips                  cavium_octeon_defconfig
nds32                               defconfig
arm                      tct_hammer_defconfig
powerpc                      obs600_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                  colibri_pxa270_defconfig
arm                          imote2_defconfig
arm                         shannon_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
arm                         orion5x_defconfig
xtensa                           allyesconfig
arm                       imx_v4_v5_defconfig
powerpc                      ep88xc_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
h8300                               defconfig
m68k                            q40_defconfig
arm                            mmp2_defconfig
csky                             alldefconfig
mips                       bmips_be_defconfig
powerpc                 canyonlands_defconfig
mips                      loongson3_defconfig
mips                        maltaup_defconfig
mips                           ip22_defconfig
sh                           se7721_defconfig
sh                          rsk7269_defconfig
ia64                          tiger_defconfig
arm                             rpc_defconfig
powerpc                      ppc40x_defconfig
powerpc                    adder875_defconfig
arm                            hisi_defconfig
arm                         s3c2410_defconfig
arm                       spear13xx_defconfig
sh                   sh7724_generic_defconfig
csky                                defconfig
sh                  sh7785lcr_32bit_defconfig
riscv                    nommu_k210_defconfig
m68k                       m5208evb_defconfig
x86_64                           alldefconfig
mips                      maltaaprp_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             alldefconfig
sh                        edosk7705_defconfig
sh                           se7750_defconfig
powerpc                    socrates_defconfig
powerpc                     ksi8560_defconfig
mips                     loongson1b_defconfig
x86_64                              defconfig
arm                          badge4_defconfig
mips                   sb1250_swarm_defconfig
arm                         nhk8815_defconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
mips                           jazz_defconfig
powerpc                           allnoconfig
sh                          landisk_defconfig
m68k                        m5307c3_defconfig
sh                               j2_defconfig
alpha                            allyesconfig
powerpc                     tqm5200_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
mips                         cobalt_defconfig
xtensa                generic_kc705_defconfig
arm                           stm32_defconfig
arm                           omap1_defconfig
arc                           tb10x_defconfig
arm                          exynos_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           ip32_defconfig
h8300                            allyesconfig
h8300                       h8s-sim_defconfig
mips                       lemote2f_defconfig
sparc64                             defconfig
powerpc                   currituck_defconfig
sh                           se7780_defconfig
mips                          rm200_defconfig
powerpc                       ppc64_defconfig
mips                          ath79_defconfig
arc                     haps_hs_smp_defconfig
powerpc                   microwatt_defconfig
sh                          urquell_defconfig
sh                          r7780mp_defconfig
arm                       cns3420vb_defconfig
mips                          ath25_defconfig
m68k                             allyesconfig
arm                             mxs_defconfig
riscv                               defconfig
powerpc                     ppa8548_defconfig
arc                        nsimosci_defconfig
powerpc                    amigaone_defconfig
arm                         s5pv210_defconfig
arm                           viper_defconfig
sh                          lboxre2_defconfig
arm                         socfpga_defconfig
x86_64                           allyesconfig
arm                             pxa_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           xway_defconfig
arc                            hsdk_defconfig
arm                        magician_defconfig
powerpc                     akebono_defconfig
mips                     cu1830-neo_defconfig
arm                            zeus_defconfig
sh                            migor_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        mini2440_defconfig
powerpc                      pcm030_defconfig
microblaze                      mmu_defconfig
powerpc                     tqm8540_defconfig
powerpc                     kmeter1_defconfig
arm                        multi_v7_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
sh                               alldefconfig
sh                         apsh4a3a_defconfig
powerpc                      cm5200_defconfig
arc                        vdk_hs38_defconfig
arm                      pxa255-idp_defconfig
arm                  colibri_pxa300_defconfig
arm                           h3600_defconfig
powerpc                 mpc836x_mds_defconfig
alpha                            alldefconfig
powerpc                       ebony_defconfig
mips                         tb0226_defconfig
sh                             sh03_defconfig
m68k                         apollo_defconfig
riscv                            allyesconfig
arm                            xcep_defconfig
sparc                       sparc64_defconfig
arm                            pleb_defconfig
powerpc                        fsp2_defconfig
arm                       multi_v4t_defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
x86_64               randconfig-a004-20210814
x86_64               randconfig-a006-20210814
x86_64               randconfig-a003-20210814
x86_64               randconfig-a001-20210814
x86_64               randconfig-a005-20210814
x86_64               randconfig-a002-20210814
i386                 randconfig-a004-20210812
i386                 randconfig-a003-20210812
i386                 randconfig-a002-20210812
i386                 randconfig-a001-20210812
i386                 randconfig-a006-20210812
i386                 randconfig-a005-20210812
i386                 randconfig-a004-20210814
i386                 randconfig-a002-20210814
i386                 randconfig-a001-20210814
i386                 randconfig-a003-20210814
i386                 randconfig-a006-20210814
i386                 randconfig-a005-20210814
i386                 randconfig-a004-20210810
i386                 randconfig-a002-20210810
i386                 randconfig-a001-20210810
i386                 randconfig-a003-20210810
i386                 randconfig-a006-20210810
i386                 randconfig-a005-20210810
i386                 randconfig-a004-20210813
i386                 randconfig-a003-20210813
i386                 randconfig-a001-20210813
i386                 randconfig-a002-20210813
i386                 randconfig-a006-20210813
i386                 randconfig-a005-20210813
i386                 randconfig-a004-20210811
i386                 randconfig-a001-20210811
i386                 randconfig-a002-20210811
i386                 randconfig-a003-20210811
i386                 randconfig-a006-20210811
i386                 randconfig-a005-20210811
x86_64               randconfig-a013-20210811
x86_64               randconfig-a011-20210811
x86_64               randconfig-a012-20210811
x86_64               randconfig-a016-20210811
x86_64               randconfig-a014-20210811
x86_64               randconfig-a015-20210811
x86_64               randconfig-a011-20210813
x86_64               randconfig-a013-20210813
x86_64               randconfig-a012-20210813
x86_64               randconfig-a016-20210813
x86_64               randconfig-a015-20210813
x86_64               randconfig-a014-20210813
x86_64               randconfig-a016-20210808
x86_64               randconfig-a012-20210808
x86_64               randconfig-a013-20210808
x86_64               randconfig-a011-20210808
x86_64               randconfig-a014-20210808
x86_64               randconfig-a015-20210808
i386                 randconfig-a011-20210812
i386                 randconfig-a015-20210812
i386                 randconfig-a013-20210812
i386                 randconfig-a014-20210812
i386                 randconfig-a016-20210812
i386                 randconfig-a012-20210812
i386                 randconfig-a011-20210814
i386                 randconfig-a015-20210814
i386                 randconfig-a013-20210814
i386                 randconfig-a014-20210814
i386                 randconfig-a016-20210814
i386                 randconfig-a012-20210814
i386                 randconfig-a011-20210811
i386                 randconfig-a015-20210811
i386                 randconfig-a014-20210811
i386                 randconfig-a013-20210811
i386                 randconfig-a016-20210811
i386                 randconfig-a012-20210811
i386                 randconfig-a011-20210810
i386                 randconfig-a015-20210810
i386                 randconfig-a013-20210810
i386                 randconfig-a014-20210810
i386                 randconfig-a016-20210810
i386                 randconfig-a012-20210810
i386                 randconfig-a011-20210813
i386                 randconfig-a015-20210813
i386                 randconfig-a014-20210813
i386                 randconfig-a013-20210813
i386                 randconfig-a016-20210813
i386                 randconfig-a012-20210813
i386                 randconfig-a012-20210809
i386                 randconfig-a015-20210809
i386                 randconfig-a011-20210809
i386                 randconfig-a013-20210809
i386                 randconfig-a014-20210809
i386                 randconfig-a016-20210809
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210811
x86_64               randconfig-c001-20210812
x86_64               randconfig-c001-20210813
x86_64               randconfig-c001-20210810
x86_64               randconfig-c001-20210814
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812
x86_64               randconfig-a013-20210814
x86_64               randconfig-a011-20210814
x86_64               randconfig-a016-20210814
x86_64               randconfig-a012-20210814
x86_64               randconfig-a014-20210814
x86_64               randconfig-a015-20210814
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809
x86_64               randconfig-a004-20210811
x86_64               randconfig-a006-20210811
x86_64               randconfig-a003-20210811
x86_64               randconfig-a002-20210811
x86_64               randconfig-a005-20210811
x86_64               randconfig-a001-20210811

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
