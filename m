Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747F35032CA
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Apr 2022 07:28:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KgMDd0Mk2z3bZ4
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Apr 2022 15:28:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gStIW75T;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gStIW75T; dkim-atps=neutral
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KgMDW1LYGz2xmV
 for <linux-erofs@lists.ozlabs.org>; Sat, 16 Apr 2022 15:28:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650086907; x=1681622907;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=FpuJW1t1F0YkdUCDwR7mCT7ea1HPRqCJfU2nukNSqmY=;
 b=gStIW75Tr8YQrVYdNQXVbZqPIBBtLZq9QYzg/4cDtT7b8s5+O4ddPeiE
 1WlwDAODTU15MLi+ygef5NfKj6Wo/Z265AMkYcxERm99YiwLRUQHRjsVP
 QKDsB5eK/XCNiFIYAnsGdj8t1CJMPiIjq7ATvFobm4xkqdLY3rFB4buvH
 amG5lpIuULza2vWmTMgikjVTH4esTPlQlbIXJHp4KpH+wm0gVAABFO5Sc
 2lANtlNk3By9n8nxR/Pdo5LorOGOUKSaqJRWw4ySauZNi+UfyEWWtaPBf
 24gnKEB7XUnsXtp1BbIVTxesB9K+E+1SNCkJ8W3/28Zv20i07f5XmWKdJ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="323711421"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="323711421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2022 22:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="726020487"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
 by orsmga005.jf.intel.com with ESMTP; 15 Apr 2022 22:26:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nfaxO-0002ob-10;
 Sat, 16 Apr 2022 05:26:50 +0000
Date: Sat, 16 Apr 2022 13:26:33 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 8b1ac84dcf2cf0fc86f29e92e5c63c4862de6e55
Message-ID: <625a5389.fy6iBlhHyVLU3QPa%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 8b1ac84dcf2cf0fc86f29e92e5c63c4862de6e55  Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

elapsed time: 723m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220415
powerpc              randconfig-c003-20220414
s390                          debug_defconfig
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                           sun3_defconfig
arm                       imx_v6_v7_defconfig
sh                               j2_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
arc                     haps_hs_smp_defconfig
ia64                                defconfig
arm                        trizeps4_defconfig
mips                         db1xxx_defconfig
mips                      fuloong2e_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          lpd270_defconfig
sh                          polaris_defconfig
arm                            xcep_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
openrisc                            defconfig
m68k                             allyesconfig
powerpc64                        alldefconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
sh                          rsk7264_defconfig
sh                            hp6xx_defconfig
arm                           corgi_defconfig
alpha                            alldefconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                   motionpro_defconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
um                                  defconfig
powerpc                     tqm8555_defconfig
x86_64                              defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220414
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220414
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
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
powerpc                        icon_defconfig
arm                        neponset_defconfig
powerpc                      ppc64e_defconfig
mips                     cu1000-neo_defconfig
arm                       aspeed_g4_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220414
hexagon              randconfig-r045-20220414
riscv                randconfig-r042-20220414
s390                 randconfig-r044-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
