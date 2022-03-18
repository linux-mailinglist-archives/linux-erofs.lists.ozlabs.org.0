Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2E4DDC49
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 15:56:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKnC95pLqz2xBL
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 01:56:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=URHLStMg;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=URHLStMg; dkim-atps=neutral
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKnBb3qyxz30Lp
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 01:55:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647615351; x=1679151351;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=zceFTzaScHnBTR/Sm8utkhvMpTKAjmjHKPE6Y2usu08=;
 b=URHLStMg8Pva0o4mMNASwkByFAzEAvkSwrGbxvG5FY4igEQ1LiED2Xcy
 MNj54qKlqqUCcJs+pP12ZlZhWS67yE/vyPKboYIfoIrfg4JtOd2DhvPH5
 2lb/lOUaR4K7PIAuLfH/NudInrv0FOvodAB/qdTerhlaiIvzafSTHJhpH
 yBl9wlNxAqowq2OQlcZ2tFvB4tyewqksyGi1vXDw60p/XslkMrP3DC9+B
 Wel5P0ZgQeDto4NU8q9RLfihEnfXMJxTt6uOMrrpxN3LWPy2/qbWylRhy
 Y1QGE3x3oMmPbtF7D3/UIBlPt7bgsccxBouaVK6TR7IYcnhaCddUqsNON Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257336636"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="257336636"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 07:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="635779463"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2022 07:54:42 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nVE01-000Eq9-99; Fri, 18 Mar 2022 14:54:41 +0000
Date: Fri, 18 Mar 2022 22:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 a1108dcd9373a98f7018aa4310076260b8ecfc0b
Message-ID: <62349d25.Ba6bLYhNE8XV76EW%lkp@intel.com>
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
branch HEAD: a1108dcd9373a98f7018aa4310076260b8ecfc0b  erofs: rename ctime to mtime

elapsed time: 728m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                           gcw0_defconfig
m68k                          atari_defconfig
sh                        edosk7705_defconfig
arm                             pxa_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
s390                             allyesconfig
powerpc                      bamboo_defconfig
sh                              ul2_defconfig
um                             i386_defconfig
arc                              allyesconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
openrisc                  or1klitex_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
powerpc                      pcm030_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                       m5208evb_defconfig
sparc64                             defconfig
powerpc                        warp_defconfig
powerpc64                           defconfig
mips                           jazz_defconfig
x86_64                              defconfig
arm                        clps711x_defconfig
riscv                               defconfig
sh                          rsk7201_defconfig
powerpc                      pasemi_defconfig
powerpc                      mgcoge_defconfig
powerpc                     ep8248e_defconfig
sh                            titan_defconfig
powerpc                     sequoia_defconfig
mips                         tb0226_defconfig
sparc                               defconfig
sh                   sh7770_generic_defconfig
m68k                            q40_defconfig
mips                     decstation_defconfig
mips                           xway_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
s390                 randconfig-c005-20220318
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
mips                 randconfig-c004-20220318
i386                          randconfig-c001
arm                  randconfig-c002-20220317
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
s390                 randconfig-c005-20220317
powerpc                      ppc44x_defconfig
powerpc                     mpc512x_defconfig
riscv                            alldefconfig
mips                      maltaaprp_defconfig
mips                     loongson1c_defconfig
powerpc                 mpc836x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
