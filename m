Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C6536F02
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 03:19:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9ggN4GRsz3bk4
	for <lists+linux-erofs@lfdr.de>; Sun, 29 May 2022 11:19:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RFh4LaPx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RFh4LaPx;
	dkim-atps=neutral
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9ggB0rXCz2ywY
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 May 2022 11:19:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653787159; x=1685323159;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v4NiNIWDhTiC8mRd/373/K1ZVtGGTEM66ko7GZ7loBc=;
  b=RFh4LaPx479XE+2Kr1pjI3Qssae0JujQEmvfle939gTCQyuw2hhFF4Mk
   4IWFGIKLkVCyUg4H3vQJn64uBbvhCDs8vy1F+S+Pg3LQDRvLNVY4ZnvHW
   FB4evCuMll4a40uGCfOMw5MyoHKDKQoVqAaZZfNQtw80QWDaTXNSBXfS8
   3enbBgKBCQaIiCPEGW7pPQlLSf0DSUOMl1rpPB24LpE4alt7QPlf8tUBB
   h00/l9GHGhRc+iFOpJnLd5qufKXYfAacEai1Apc42jTIwgSVH3x4uqMgy
   uPwPt9NnXMwrOaxNno+sFFjMQlZEXv/0zJ3fJ3fRE12yeGc76/yzKMCRe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="255222724"
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="255222724"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 18:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="705676970"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 May 2022 18:18:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nv7ZE-0000eS-8y;
	Sun, 29 May 2022 01:18:04 +0000
Date: Sun, 29 May 2022 09:17:47 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 82c11da29ca5f4a99811100027c9991504a87110
Message-ID: <6292c9bb.Vr5LHwqLQU7mg+ty%lkp@intel.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev
branch HEAD: 82c11da29ca5f4a99811100027c9991504a87110  erofs: update documentation

elapsed time: 723m

configs tested: 141
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
sh                          sdk7786_defconfig
alpha                            allyesconfig
powerpc                      cm5200_defconfig
powerpc64                           defconfig
um                                  defconfig
sh                               alldefconfig
arm                           sama5_defconfig
um                           x86_64_defconfig
openrisc                 simple_smp_defconfig
sh                          r7780mp_defconfig
s390                             allyesconfig
sh                           se7721_defconfig
arm                           u8500_defconfig
sh                           se7712_defconfig
sh                            shmin_defconfig
arm                      footbridge_defconfig
arc                           tb10x_defconfig
arm                           h3600_defconfig
powerpc                     pq2fads_defconfig
arm                            qcom_defconfig
powerpc                        cell_defconfig
arc                                 defconfig
m68k                          amiga_defconfig
x86_64                              defconfig
parisc                           allyesconfig
arm                        multi_v7_defconfig
powerpc                 mpc837x_mds_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          badge4_defconfig
m68k                        mvme147_defconfig
openrisc                    or1ksim_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220524
arm                  randconfig-c002-20220526
arm                  randconfig-c002-20220529
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220527
arc                  randconfig-r043-20220526
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220526
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220526
riscv                randconfig-r042-20220524
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220529
x86_64                        randconfig-c007
s390                 randconfig-c005-20220529
i386                          randconfig-c001
powerpc              randconfig-c003-20220529
riscv                randconfig-c006-20220529
mips                 randconfig-c004-20220529
mips                     loongson2k_defconfig
powerpc                      obs600_defconfig
arm                          collie_defconfig
arm                      tct_hammer_defconfig
mips                         tb0219_defconfig
mips                           ip22_defconfig
mips                  cavium_octeon_defconfig
powerpc                    socrates_defconfig
arm                      pxa255-idp_defconfig
arm                       aspeed_g4_defconfig
mips                     cu1830-neo_defconfig
arm                            dove_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r041-20220527
hexagon              randconfig-r045-20220527
riscv                randconfig-r042-20220527
s390                 randconfig-r044-20220527
hexagon              randconfig-r045-20220524
hexagon              randconfig-r045-20220526
hexagon              randconfig-r041-20220526
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
