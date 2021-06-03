Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA239AEDF
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jun 2021 01:48:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fx2fJ0vb5z2yyj
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jun 2021 09:48:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fx2fC2cyJz2xYg
 for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jun 2021 09:48:28 +1000 (AEST)
IronPort-SDR: YjERRFRY2XJa38iBtrv1NxSmV3/NA1Ss4VA7A/TS4+0GN93SyR/7fljrIrO1bAnLny3su9POnQ
 7gzv2kSq3FSg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191519627"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="191519627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 16:48:23 -0700
IronPort-SDR: GyBuRPF8l3FKWozRqhwKjos8mHyL0AdiladmH8szY2KC3h/2sQmYuqAbsje64jDhheqt89KX6X
 GjsuNNWRp7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="633869042"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2021 16:48:21 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lox4W-0006RP-VN; Thu, 03 Jun 2021 23:48:20 +0000
Date: Fri, 04 Jun 2021 07:47:45 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ac1c889d37da32c7f3cf3cda51db443fd21ce1ec
Message-ID: <60b96a21.2lCrtGAj33QUwxRB%lkp@intel.com>
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
branch HEAD: ac1c889d37da32c7f3cf3cda51db443fd21ce1ec  erofs: clean up file headers & footers

elapsed time: 1821m

configs tested: 311
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         socfpga_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
mips                        qi_lb60_defconfig
arm                      footbridge_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
powerpc                      katmai_defconfig
powerpc                   currituck_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      arches_defconfig
h8300                     edosk2674_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        multi_v5_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
mips                          rm200_defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
sh                         ap325rxa_defconfig
sh                           se7722_defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
parisc                              defconfig
sh                               j2_defconfig
powerpc                 mpc837x_mds_defconfig
mips                       lemote2f_defconfig
arm                              alldefconfig
s390                       zfcpdump_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
xtensa                           allyesconfig
xtensa                generic_kc705_defconfig
sh                          rsk7203_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sequoia_defconfig
arm                         orion5x_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
arm                         lpc18xx_defconfig
riscv                            allyesconfig
arm                          exynos_defconfig
powerpc                     kilauea_defconfig
sh                        sh7757lcr_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
mips                           rs90_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc64                        alldefconfig
arm                       omap2plus_defconfig
xtensa                    smp_lx200_defconfig
arm                           omap1_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            zeus_defconfig
m68k                          amiga_defconfig
mips                            gpr_defconfig
powerpc                     redwood_defconfig
powerpc                    gamecube_defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
sh                          kfr2r09_defconfig
arm                  colibri_pxa270_defconfig
mips                            e55_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
powerpc                     tqm5200_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          simpad_defconfig
arm                       aspeed_g4_defconfig
sh                           se7751_defconfig
mips                      bmips_stb_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
arm                       imx_v4_v5_defconfig
sparc                            allyesconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
nios2                               defconfig
powerpc                     pseries_defconfig
sh                           se7343_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
sh                            hp6xx_defconfig
um                            kunit_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
nds32                               defconfig
sh                   secureedge5410_defconfig
csky                             alldefconfig
xtensa                    xip_kc705_defconfig
arm                      tct_hammer_defconfig
arm                           sunxi_defconfig
sh                          rsk7264_defconfig
arm                            lart_defconfig
m68k                        mvme147_defconfig
sh                           se7619_defconfig
powerpc                 mpc834x_mds_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
mips                  cavium_octeon_defconfig
arm                         palmz72_defconfig
mips                      fuloong2e_defconfig
powerpc                      acadia_defconfig
sh                        sh7763rdp_defconfig
arc                              alldefconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                         tb0219_defconfig
m68k                        m5307c3_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
powerpc                    ge_imp3a_defconfig
openrisc                  or1klitex_defconfig
powerpc64                           defconfig
arm                           sama5_defconfig
h8300                            alldefconfig
mips                           ci20_defconfig
arm                           tegra_defconfig
powerpc                          allmodconfig
sh                              ul2_defconfig
mips                     loongson2k_defconfig
mips                      pistachio_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7785lcr_defconfig
powerpc                   motionpro_defconfig
sh                          r7780mp_defconfig
arm                         assabet_defconfig
mips                         cobalt_defconfig
arc                        vdk_hs38_defconfig
um                             i386_defconfig
riscv                            allmodconfig
powerpc                      ppc44x_defconfig
powerpc                     akebono_defconfig
parisc                           alldefconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
mips                      malta_kvm_defconfig
arm                          moxart_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
arm                       mainstone_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7721_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210602
x86_64               randconfig-a004-20210602
x86_64               randconfig-a003-20210602
x86_64               randconfig-a006-20210602
x86_64               randconfig-a005-20210602
x86_64               randconfig-a001-20210602
i386                 randconfig-a003-20210602
i386                 randconfig-a006-20210602
i386                 randconfig-a004-20210602
i386                 randconfig-a001-20210602
i386                 randconfig-a005-20210602
i386                 randconfig-a002-20210602
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
x86_64               randconfig-a015-20210601
x86_64               randconfig-a011-20210601
x86_64               randconfig-a012-20210601
x86_64               randconfig-a014-20210601
x86_64               randconfig-a016-20210601
x86_64               randconfig-a013-20210601
i386                 randconfig-a015-20210602
i386                 randconfig-a013-20210602
i386                 randconfig-a016-20210602
i386                 randconfig-a011-20210602
i386                 randconfig-a014-20210602
i386                 randconfig-a012-20210602
i386                 randconfig-a015-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-b001-20210601
x86_64               randconfig-b001-20210602
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a015-20210602
x86_64               randconfig-a011-20210602
x86_64               randconfig-a012-20210602
x86_64               randconfig-a014-20210602
x86_64               randconfig-a016-20210602
x86_64               randconfig-a013-20210602
x86_64               randconfig-a002-20210601
x86_64               randconfig-a004-20210601
x86_64               randconfig-a003-20210601
x86_64               randconfig-a006-20210601
x86_64               randconfig-a005-20210601
x86_64               randconfig-a001-20210601

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
