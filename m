Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A001B51636C
	for <lists+linux-erofs@lfdr.de>; Sun,  1 May 2022 11:39:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Krh4h40qgz3bWD
	for <lists+linux-erofs@lfdr.de>; Sun,  1 May 2022 19:39:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SFt8QEab;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SFt8QEab; dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Krh4X5HWhz2xnG
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 May 2022 19:38:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651397933; x=1682933933;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=A4a4N+K5CeBio/ZKGQF+4ekWr2MPi1du63ooVcoTEFY=;
 b=SFt8QEabkQIOiYpwVtY96k1WilRVbh8ZXZyXr5S1vVd/j67lWWjxWi2Y
 d9Ft4PjyH8NogkUYCwFZDzwRHJPKNTf5uiTYQlC0fJoXSbaLyUjVxUCN9
 FfadHtq3l3U0TXEdLRDgIrV/H48YAlLnWXrwlonfhuptqbOeDGFM07SP2
 U56mARtqLuI4b3TPDJaFScd+XvnICU1rAGF4jzejMJtZHF6BZ3oCH+q8a
 P+ZZ39CpluGqOnPSLsCM5a8v8Tibs4TzjMxKF+m71i5Y3Mp52lio8HxJl
 N8NjZC8MUqeVUB2/wvLjJYMLbUyXwgaKpP6716arDa+nU+RSebdUcKhUV w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="266847775"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="266847775"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 02:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="619446387"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 01 May 2022 02:37:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nl61C-0008em-W9;
 Sun, 01 May 2022 09:37:30 +0000
Date: Sun, 01 May 2022 17:36:53 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 011c045788edeb4aabb326fab459efbcaa1e8c03
Message-ID: <626e54b5.YI2iUiU9UI9mKlQ1%lkp@intel.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 011c045788edeb4aabb326fab459efbcaa1e8c03  erofs: add 'fsid' mount option

elapsed time: 6805m

configs tested: 252
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220425
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
xtensa                          iss_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
mips                             allyesconfig
mips                         tb0226_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       bvme6000_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
arm                      jornada720_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
h8300                     edosk2674_defconfig
arm                      footbridge_defconfig
s390                             allmodconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
sh                         microdev_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
sh                             sh03_defconfig
arm                       imx_v6_v7_defconfig
m68k                            mac_defconfig
ia64                         bigsur_defconfig
m68k                          sun3x_defconfig
arm                         nhk8815_defconfig
arm                            lart_defconfig
powerpc                         ps3_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc8540_ads_defconfig
alpha                               defconfig
m68k                           sun3_defconfig
arc                                 defconfig
sh                          rsk7264_defconfig
powerpc                     mpc83xx_defconfig
sh                      rts7751r2d1_defconfig
arm                        mini2440_defconfig
sh                ecovec24-romimage_defconfig
sparc                               defconfig
sh                          landisk_defconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
arm                          lpd270_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arm                        cerfcube_defconfig
arm                      integrator_defconfig
um                               alldefconfig
sh                          rsk7201_defconfig
arm                        oxnas_v6_defconfig
arm                        multi_v7_defconfig
microblaze                          defconfig
powerpc                     pq2fads_defconfig
arm                           sunxi_defconfig
sh                           se7751_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
sparc64                          alldefconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
sh                   rts7751r2dplus_defconfig
alpha                            allyesconfig
powerpc                    amigaone_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                      cm5200_defconfig
i386                                defconfig
mips                           jazz_defconfig
powerpc                      makalu_defconfig
powerpc                      chrp32_defconfig
powerpc                    klondike_defconfig
mips                          rb532_defconfig
sh                          kfr2r09_defconfig
openrisc                    or1ksim_defconfig
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220429
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a016-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a015-20220425
i386                 randconfig-a011-20220425
i386                 randconfig-a014-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
arc                  randconfig-r043-20220428
arc                  randconfig-r043-20220429
s390                 randconfig-r044-20220429
riscv                randconfig-r042-20220429
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
s390                 randconfig-c005-20220428
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
riscv                randconfig-c006-20220427
mips                 randconfig-c004-20220427
arm                  randconfig-c002-20220427
powerpc              randconfig-c003-20220427
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
powerpc                      katmai_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
mips                          ath25_defconfig
powerpc                 mpc8315_rdb_defconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
i386                             allyesconfig
arm                         hackkit_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
arm                          pxa168_defconfig
mips                         tb0287_defconfig
powerpc                 linkstation_defconfig
powerpc                        fsp2_defconfig
arm                      pxa255-idp_defconfig
riscv                             allnoconfig
mips                      bmips_stb_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a002-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a003-20220425
i386                 randconfig-a004-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a006-20220425
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
