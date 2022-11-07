Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45161F9CE
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Nov 2022 17:31:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N5cDm3nzyz3cML
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 03:31:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+NqijE5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+NqijE5;
	dkim-atps=neutral
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N5cDc3ZZYz3cHw
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Nov 2022 03:31:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667838672; x=1699374672;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DsmOlMUyeWJr/m98g0S+/vjyvy2KmYNKJRUiIXGVbog=;
  b=f+NqijE5P7tSWMQzJaJGBxaHoDk7HNvL4wtnc573RIYpslS8wBOqOxgT
   7HhRp2VXvI+sB0QgQ8wA2KM0sMdrCU4o9+IiZkfPgAREYt/m7J6CSahl6
   OJF5D5XZlnC7sG5ChzMv+F4qHTq6Rq6PH9b6N80T5uehvbUk9qRFHc7Un
   XRvY07qh8/5SUVNPyMcQBYSuMQsCct1/i1qzzhrpckEswvaFEFX59+//l
   MOZnO1EqOMsUOqZyeRYmaVNATc5f9pNHBL7Ehj5g5cdRn0E2jiQiTrq8J
   4930zy2k8m39v2NxZ7wyO2QKMD2fometTzJDUX3JpMC5UCHKh/R14Qhix
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="396752415"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="396752415"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:30:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="587032000"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="587032000"
Received: from lkp-server01.sh.intel.com (HELO 462403710aa9) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Nov 2022 08:30:53 -0800
Received: from kbuild by 462403710aa9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1os51Q-0000or-1j;
	Mon, 07 Nov 2022 16:30:52 +0000
Date: Tue, 08 Nov 2022 00:29:57 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 398be32f969bdb8c4566a17206cc8dd02ca73cda
Message-ID: <63693285.SDw3E1LNm4r6yLg1%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 398be32f969bdb8c4566a17206cc8dd02ca73cda  erofs: get correct count for unmapped range in fscache mode

elapsed time: 721m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
arc                               allnoconfig
alpha                             allnoconfig
sh                               allmodconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
riscv                randconfig-r042-20221106
arc                  randconfig-r043-20221106
s390                 randconfig-r044-20221106
ia64                             allmodconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-c001-20221107
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20221107
m68k                         apollo_defconfig
powerpc                     taishan_defconfig
arm                         lpc18xx_defconfig
mips                         rt305x_defconfig
microblaze                      mmu_defconfig
csky                             alldefconfig
ia64                      gensparse_defconfig
sh                     magicpanelr2_defconfig
sh                          sdk7786_defconfig
sh                         microdev_defconfig
x86_64               randconfig-a006-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                      integrator_defconfig
arm                     eseries_pxa_defconfig
m68k                                defconfig
s390                          debug_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                     sequoia_defconfig
parisc                generic-64bit_defconfig
mips                            gpr_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                    adder875_defconfig
powerpc                   motionpro_defconfig
xtensa                              defconfig
ia64                            zx1_defconfig
mips                      maltasmvp_defconfig
xtensa                         virt_defconfig
powerpc                      bamboo_defconfig
sh                   sh7724_generic_defconfig
loongarch                         allnoconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a013-20221107
i386                 randconfig-a015-20221107
i386                 randconfig-a016-20221107
i386                 randconfig-a011-20221107
i386                 randconfig-a014-20221107
i386                 randconfig-a012-20221107
x86_64               randconfig-a014-20221107
x86_64               randconfig-a011-20221107
x86_64               randconfig-a013-20221107
x86_64               randconfig-a012-20221107
x86_64               randconfig-a015-20221107
x86_64               randconfig-a016-20221107
mips                     cu1000-neo_defconfig
arm                         orion5x_defconfig
powerpc                    mvme5100_defconfig
arm                          pcm027_defconfig
powerpc                        icon_defconfig
powerpc                     mpc5200_defconfig
arm                         palmz72_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
