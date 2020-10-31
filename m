Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B35E02A13EA
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Oct 2020 08:13:31 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CNVlC2W8qzDqwT
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Oct 2020 18:13:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.136; helo=mga12.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CNVl14nr9zDqvY
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Oct 2020 18:13:11 +1100 (AEDT)
IronPort-SDR: CdMHtnBC8FU4sai66P9f4ofzejIdPMS/34dNh7Flg2qjoHeZKxggfhuofOYqC4LK9Iv9HT59oW
 A5fC+7dqPVKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147990658"
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; d="scan'208";a="147990658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2020 00:13:07 -0700
IronPort-SDR: aPZ8lkQ2rasTsNg0CxkVWpfr33QWlwFPPfE8ng525+yqxgZh81EmpdHJd0tK9DEgU3p74wB085
 +lYw2JWp4Qsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,436,1596524400"; d="scan'208";a="526123422"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2020 00:13:06 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kYl4U-0000Sv-28; Sat, 31 Oct 2020 07:13:06 +0000
Date: Sat, 31 Oct 2020 15:12:08 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f2f0ef499175782eb235bff229b4742fd7a91bfa
Message-ID: <5f9d0e48.ZmfZGFyPN/FNo/xz%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev-test
branch HEAD: f2f0ef499175782eb235bff229b4742fd7a91bfa  erofs: complete a missing case for inplace I/O

elapsed time: 725m

configs tested: 153
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     taishan_defconfig
arm                        magician_defconfig
microblaze                          defconfig
arm                          pxa910_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
mips                      maltasmvp_defconfig
m68k                        mvme16x_defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
arc                     nsimosci_hs_defconfig
powerpc                   motionpro_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                           omap1_defconfig
powerpc                     kilauea_defconfig
mips                  maltasmvp_eva_defconfig
arm                   milbeaut_m10v_defconfig
sparc                       sparc32_defconfig
powerpc                     skiroot_defconfig
arc                        vdk_hs38_defconfig
arm                          exynos_defconfig
c6x                        evmc6457_defconfig
powerpc                      ep88xc_defconfig
mips                malta_qemu_32r6_defconfig
arm                     am200epdkit_defconfig
mips                       lemote2f_defconfig
s390                          debug_defconfig
arm                            pleb_defconfig
ia64                          tiger_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  nommu_kc705_defconfig
mips                malta_kvm_guest_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
arm                          ixp4xx_defconfig
riscv                            alldefconfig
sh                          sdk7786_defconfig
arm                        cerfcube_defconfig
sh                            hp6xx_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1c_defconfig
powerpc                     kmeter1_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8540_ads_defconfig
mips                           mtx1_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
arm                        multi_v5_defconfig
alpha                            alldefconfig
powerpc                       ebony_defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                         ps3_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
arm                           efm32_defconfig
sh                      rts7751r2d1_defconfig
powerpc                        fsp2_defconfig
arc                        nsim_700_defconfig
microblaze                      mmu_defconfig
arc                     haps_hs_smp_defconfig
um                             i386_defconfig
mips                          ath79_defconfig
openrisc                         alldefconfig
arm                        shmobile_defconfig
sh                ecovec24-romimage_defconfig
ia64                      gensparse_defconfig
sh                           se7721_defconfig
mips                        workpad_defconfig
arm                         s3c6400_defconfig
arm                            lart_defconfig
powerpc                  iss476-smp_defconfig
mips                     loongson1b_defconfig
sparc                            allyesconfig
riscv                               defconfig
arm                       multi_v4t_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201030
x86_64               randconfig-a001-20201030
x86_64               randconfig-a002-20201030
x86_64               randconfig-a003-20201030
x86_64               randconfig-a006-20201030
x86_64               randconfig-a004-20201030
i386                 randconfig-a005-20201030
i386                 randconfig-a003-20201030
i386                 randconfig-a002-20201030
i386                 randconfig-a001-20201030
i386                 randconfig-a006-20201030
i386                 randconfig-a004-20201030
i386                 randconfig-a011-20201030
i386                 randconfig-a014-20201030
i386                 randconfig-a015-20201030
i386                 randconfig-a012-20201030
i386                 randconfig-a013-20201030
i386                 randconfig-a016-20201030
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20201030
x86_64               randconfig-a014-20201030
x86_64               randconfig-a015-20201030
x86_64               randconfig-a016-20201030
x86_64               randconfig-a011-20201030
x86_64               randconfig-a012-20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
