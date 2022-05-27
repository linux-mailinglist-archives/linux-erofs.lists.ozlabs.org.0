Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25564536461
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 16:54:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L8nrr3BZ8z3bmS
	for <lists+linux-erofs@lfdr.de>; Sat, 28 May 2022 00:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c/846N7r;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c/846N7r;
	dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L8nrf0f3rz305M
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 May 2022 00:54:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653663266; x=1685199266;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bY2HZFjQnR8jM1mxcWXkDJdLZ7r8IWkDlIXE71Rblf0=;
  b=c/846N7rGbMf0XCZy+oREVLfrScmZk/2nMhoS7P1BNRfu/q6n1p+wTGb
   FYiasL0oUOYUzwvi5b/A9qd5gQ40PbiCbv8QB81szVbmO+BDyVRAnK0To
   jVR4gXUW/ZZ9ZkvwVtTf6ymWmHYtshQxOZS/2G6eyL6fOhFIFB799SKTb
   p05nkV8dbNu5Ch2exufKbPJzZxunFQTkcaJbo2UbKug2AOfDOf/7I1eOj
   hsYCSZ+62uoymbpNVKsLqIomyeu0OLX2vjpwi7qgHSnyAhhzklXyNWqrA
   UGEyETBqcWNW8EpUs7oiiH2XLpBcw4vx7egFyP8KXDcRwGWKpbiURg+x+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274504825"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="274504825"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="643420654"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2022 07:54:11 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1nubLu-0004rY-T8;
	Fri, 27 May 2022 14:54:10 +0000
Date: Fri, 27 May 2022 22:53:37 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ec339ed55bdf1c65ca31e750a8b9fb21f35c921d
Message-ID: <6290e5f1.km7iTlEpfvy2RacY%lkp@intel.com>
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
branch HEAD: ec339ed55bdf1c65ca31e750a8b9fb21f35c921d  erofs: leave compressed inodes unsupported in fscache mode for now

elapsed time: 788m

configs tested: 149
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
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                            mps2_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
arm                         vf610m4_defconfig
sh                            titan_defconfig
sh                           sh2007_defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
arm                          pxa3xx_defconfig
sh                ecovec24-romimage_defconfig
mips                         bigsur_defconfig
mips                  maltasmvp_eva_defconfig
arc                           tb10x_defconfig
powerpc                         ps3_defconfig
powerpc                      ep88xc_defconfig
sh                          sdk7786_defconfig
powerpc                   motionpro_defconfig
nios2                         10m50_defconfig
arm                            zeus_defconfig
um                               alldefconfig
sh                           se7619_defconfig
sparc                       sparc32_defconfig
arm                            pleb_defconfig
powerpc                     asp8347_defconfig
sh                        apsh4ad0a_defconfig
arm                     eseries_pxa_defconfig
sh                           se7343_defconfig
sparc                       sparc64_defconfig
sh                           se7780_defconfig
arm                          pxa910_defconfig
riscv                    nommu_k210_defconfig
mips                 decstation_r4k_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
s390                       zfcpdump_defconfig
m68k                        m5407c3_defconfig
powerpc                     ep8248e_defconfig
arc                            hsdk_defconfig
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
arc                  randconfig-r043-20220526
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220526
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220526
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220527
arc                  randconfig-r043-20220525
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
arm                  randconfig-c002-20220524
x86_64                        randconfig-c007
s390                 randconfig-c005-20220524
i386                          randconfig-c001
powerpc              randconfig-c003-20220524
riscv                randconfig-c006-20220524
mips                 randconfig-c004-20220524
arm                         hackkit_defconfig
mips                       rbtx49xx_defconfig
powerpc                      walnut_defconfig
mips                      pic32mzda_defconfig
powerpc                       ebony_defconfig
mips                           ip28_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
arm                        mvebu_v5_defconfig
riscv                          rv32_defconfig
arm                     am200epdkit_defconfig
powerpc                          allyesconfig
powerpc                    mvme5100_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r045-20220524
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
