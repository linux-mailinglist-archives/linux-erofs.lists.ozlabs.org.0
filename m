Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A092A4DB620
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Mar 2022 17:27:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KJbK51K6Vz30CP
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Mar 2022 03:27:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D5lqy8bE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=D5lqy8bE; dkim-atps=neutral
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KJbK04FFMz2ywF
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Mar 2022 03:27:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647448036; x=1678984036;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=DmrfRnkCYGR/PbRVQX74PKRZFtL+Hgz7fa5M0f6niBg=;
 b=D5lqy8bEj5i0jng5vUKl/wonvqbf4RFkrVLz7JbSeuEtHu98YtorFLVR
 8E9tysz0fZCEa+OnyIUSLhg9UTwCfyqXadgkSYsUkclv0LyQ3qLJsu1k2
 Q0/Z+YqSYIztPtC5KZW0n0kfkl7y3Lz8qbZBCAxWEI6Dw3at5MN6fAbdj
 UmvgosHM2ElscX6dwuB0H04+TSg3sfV0Vl6aex988GJ0s43LkuZVQSBvs
 HvQUSKt1bOWiQ5Z29Xc1MJ/L6TGWvL0q2ueQLuj1RSDUEXvRbNzT0DuUL
 FzjE3YXt6IiKtoHuGrins0thVMSoihHBIJU6CdivRCUMXigHOpIdFqNPb Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255484372"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="255484372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 09:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="690646178"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2022 09:26:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUWTO-000CcR-8i; Wed, 16 Mar 2022 16:26:06 +0000
Date: Thu, 17 Mar 2022 00:25:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 b0ab343bfb4d6b5df039200aa6a38750bee38cac
Message-ID: <62320f63.Q+4cdghiUNejnTdB%lkp@intel.com>
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
branch HEAD: b0ab343bfb4d6b5df039200aa6a38750bee38cac  erofs: support inode lookup with metabuf

elapsed time: 799m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20220314
mips                 randconfig-c004-20220314
arm                      footbridge_defconfig
mips                        vocore2_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         vf610m4_defconfig
mips                        jmr3927_defconfig
xtensa                         virt_defconfig
sh                           se7206_defconfig
sh                          landisk_defconfig
powerpc                    amigaone_defconfig
alpha                               defconfig
h8300                            alldefconfig
sh                          rsk7201_defconfig
arm                         lubbock_defconfig
powerpc                 canyonlands_defconfig
s390                          debug_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      cm5200_defconfig
arm                          badge4_defconfig
arc                         haps_hs_defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          rsk7269_defconfig
powerpc                     tqm8541_defconfig
m68k                        mvme16x_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
arm                         axm55xx_defconfig
arm                        shmobile_defconfig
arm                          pxa910_defconfig
powerpc                      pcm030_defconfig
arm                           sama5_defconfig
ia64                            zx1_defconfig
x86_64                           alldefconfig
openrisc                 simple_smp_defconfig
sparc                            alldefconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
i386                              debian-10.3
i386                             allyesconfig
i386                   debian-10.3-kselftests
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a005-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a003-20220314
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220314
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                       cns3420vb_defconfig
mips                           ip28_defconfig
powerpc                      acadia_defconfig
arm                         s3c2410_defconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_mds_defconfig
mips                      maltaaprp_defconfig
arm                       versatile_defconfig
mips                      bmips_stb_defconfig
powerpc                       ebony_defconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8560_ads_defconfig
hexagon                          alldefconfig
arm                        neponset_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     ppa8548_defconfig
arm                      pxa255-idp_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_mds_defconfig
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a015-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220313
hexagon              randconfig-r045-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
riscv                randconfig-r042-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
