Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE332357336
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 19:31:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFrz56D81z304L
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Apr 2021 03:31:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFrz31y7Mz2y0K
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Apr 2021 03:31:09 +1000 (AEST)
IronPort-SDR: ZJxFphlNGFNcOZj05wXmak4v+oWYnpSauAfojm5SbYTuX48BZlINCeBN8pYn7IKCUFiskC1UeU
 3Ynimb7toO1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="278625479"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; d="scan'208";a="278625479"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 10:31:07 -0700
IronPort-SDR: NIFWYzsChQ3CiKCn/LE2bQvvSUHjc3PzNv8Z8amR37bo+bPm2Vq+KscuzP87EoSUA/QfflAdy2
 Ut542rIOv2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; d="scan'208";a="441400874"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2021 10:31:05 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lUC1B-000DYU-1b; Wed, 07 Apr 2021 17:31:05 +0000
Date: Thu, 08 Apr 2021 01:30:23 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 df7bb621ce5ad12c32e2518f8a564d3ea29149c7
Message-ID: <606dec2f.ip8sj2I3X7OhxgcN%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: df7bb621ce5ad12c32e2518f8a564d3ea29149c7  erofs: enable big pcluster feature

elapsed time: 731m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
nds32                            alldefconfig
powerpc                   motionpro_defconfig
powerpc                 linkstation_defconfig
mips                       capcella_defconfig
arm                          pxa168_defconfig
nios2                               defconfig
arc                          axs101_defconfig
alpha                            alldefconfig
s390                                defconfig
mips                        nlm_xlp_defconfig
m68k                                defconfig
powerpc                 mpc834x_itx_defconfig
mips                  maltasmvp_eva_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
powerpc                   currituck_defconfig
arm                            qcom_defconfig
powerpc                    mvme5100_defconfig
s390                             allyesconfig
m68k                       m5275evb_defconfig
arc                        nsimosci_defconfig
sh                          lboxre2_defconfig
mips                         tb0287_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
sparc                            alldefconfig
sparc                       sparc32_defconfig
arm                       aspeed_g4_defconfig
arm                             pxa_defconfig
powerpc                      mgcoge_defconfig
arm                        keystone_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
m68k                         amcore_defconfig
alpha                            allyesconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
mips                           ip27_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
powerpc                           allnoconfig
sh                      rts7751r2d1_defconfig
sh                          rsk7264_defconfig
powerpc                          allyesconfig
mips                     loongson1c_defconfig
sh                           se7780_defconfig
s390                       zfcpdump_defconfig
nios2                         3c120_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc44x_defconfig
sh                          sdk7780_defconfig
powerpc                      arches_defconfig
csky                             alldefconfig
powerpc                        fsp2_defconfig
arm                           sunxi_defconfig
powerpc                     pq2fads_defconfig
m68k                        mvme16x_defconfig
mips                           rs90_defconfig
sh                             shx3_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
arm                        neponset_defconfig
mips                           ci20_defconfig
arm                         shannon_defconfig
mips                        jmr3927_defconfig
arm                          ep93xx_defconfig
mips                        nlm_xlr_defconfig
sh                        sh7757lcr_defconfig
arm                  colibri_pxa300_defconfig
sh                          kfr2r09_defconfig
arm                      footbridge_defconfig
xtensa                           alldefconfig
mips                      loongson3_defconfig
arc                      axs103_smp_defconfig
sh                               j2_defconfig
sh                            titan_defconfig
arm                           omap1_defconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
sh                              ul2_defconfig
xtensa                generic_kc705_defconfig
powerpc                    adder875_defconfig
arm                             rpc_defconfig
arm                        vexpress_defconfig
powerpc                          allmodconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7721_defconfig
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
ia64                          tiger_defconfig
mips                            gpr_defconfig
arc                                 defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
powerpc                      acadia_defconfig
arm                       aspeed_g5_defconfig
arm                          ixp4xx_defconfig
arm                            zeus_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          landisk_defconfig
x86_64                              defconfig
powerpc                       eiger_defconfig
arm                        trizeps4_defconfig
sh                          rsk7203_defconfig
powerpc                      pcm030_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
riscv                          rv32_defconfig
powerpc                      walnut_defconfig
arm                          simpad_defconfig
parisc                              defconfig
um                             i386_defconfig
powerpc                     ksi8560_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
