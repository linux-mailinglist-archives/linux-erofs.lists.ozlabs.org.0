Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F1B5862AC
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 04:36:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lx2LY6zHNz2ynx
	for <lists+linux-erofs@lfdr.de>; Mon,  1 Aug 2022 12:36:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aHX/jCF2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aHX/jCF2;
	dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lx2LN2cMfz2xGH
	for <linux-erofs@lists.ozlabs.org>; Mon,  1 Aug 2022 12:36:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659321372; x=1690857372;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ppXlFm1ujSuKOrXw5CxhaRKuWocAu7ZKTKIQo5R/uyk=;
  b=aHX/jCF2LXuKywnzRwHWPIEoYRJN3OAuXCv5krQKZ34XDx2wCSCZjf6y
   76qahQLde2EhrcDiaEIQDGbwuguKpVRs+tqz4pmEVZVuowRZxYYrDEiEm
   XeB4s4fSlrMH5tCoNjU7yN5YicdE7iqhm9FvEapyN5iC0wskQvQl/rtV/
   AI9aGWXrPSnAQJYvn057Z3UOwpvz0087FOkzB8aUhOXkZqniePGgdeMod
   HZxx4yg4TRVX8Hhg67T5EOtlLPqotChYr9TTmRWmLQvBkZgXIIkPEkTz2
   tFY4WD4qNlKDp7ZrJ5cD33yKlGAjLzopVVdTP6BB91kgEB96quBzWztGz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="290257816"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290257816"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="778100981"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2022 19:36:06 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oILHp-000Ehr-2p;
	Mon, 01 Aug 2022 02:36:05 +0000
Date: Mon, 01 Aug 2022 10:35:21 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 ecce9212d0fd7a2d4a4998f0c4623a66887e14c8
Message-ID: <62e73be9.U/MrkTxLSxYGRueC%lkp@intel.com>
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
branch HEAD: ecce9212d0fd7a2d4a4998f0c4623a66887e14c8  erofs: update ctx->pos for every emitted dirent

elapsed time: 716m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220731
x86_64                              defconfig
s390                 randconfig-r044-20220731
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a013
i386                          randconfig-a012
powerpc                          allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64                        randconfig-a011
mips                             allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a004
arc                              allyesconfig
i386                          randconfig-a001
powerpc                           allnoconfig
alpha                            allyesconfig
sh                               allmodconfig
riscv                randconfig-r042-20220731
m68k                             allyesconfig
i386                          randconfig-a003
i386                          randconfig-a014
m68k                             allmodconfig
x86_64                          rhel-8.3-func
ia64                             allmodconfig
i386                          randconfig-a005
arm                                 defconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
arm                              allyesconfig
arm64                            allyesconfig
arc                               allnoconfig
alpha                             allnoconfig
arm                          pxa910_defconfig
csky                              allnoconfig
riscv                             allnoconfig
arc                        nsimosci_defconfig
powerpc                      makalu_defconfig
sh                        sh7763rdp_defconfig
parisc                generic-64bit_defconfig
sparc                               defconfig
sparc                       sparc32_defconfig
mips                       bmips_be_defconfig
arm                           h3600_defconfig
powerpc                    amigaone_defconfig
powerpc                      mgcoge_defconfig
arm                         lubbock_defconfig
arm                      footbridge_defconfig
powerpc                     ep8248e_defconfig
arm                        mvebu_v7_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      chrp32_defconfig
parisc64                         alldefconfig
powerpc                 mpc834x_itx_defconfig
i386                          randconfig-c001
arm                          simpad_defconfig
arm                          iop32x_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
mips                 randconfig-c004-20220731
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                          r7780mp_defconfig
sparc                            allyesconfig
xtensa                          iss_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                            q40_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7269_defconfig
ia64                                defconfig
mips                        vocore2_defconfig
i386                 randconfig-a016-20220801
i386                 randconfig-a013-20220801
i386                 randconfig-a015-20220801
i386                 randconfig-a012-20220801
i386                 randconfig-a011-20220801
i386                 randconfig-a014-20220801
s390                 randconfig-r044-20220801
arc                  randconfig-r043-20220801
riscv                randconfig-r042-20220801
m68k                         apollo_defconfig
arm                        multi_v7_defconfig
sh                          rsk7264_defconfig
mips                             allmodconfig
sh                        sh7757lcr_defconfig

clang tested configs:
hexagon              randconfig-r041-20220731
hexagon              randconfig-r045-20220731
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                     tqm8560_defconfig
riscv                          rv32_defconfig
powerpc                     tqm5200_defconfig
arm                            dove_defconfig
powerpc                  mpc885_ads_defconfig
mips                     loongson1c_defconfig
hexagon                             defconfig
powerpc                     kmeter1_defconfig
x86_64                        randconfig-k001
x86_64               randconfig-a002-20220801
x86_64               randconfig-a001-20220801
x86_64               randconfig-a006-20220801
x86_64               randconfig-a003-20220801
x86_64               randconfig-a004-20220801
x86_64               randconfig-a005-20220801
i386                 randconfig-a003-20220801
i386                 randconfig-a006-20220801
i386                 randconfig-a005-20220801
i386                 randconfig-a001-20220801
i386                 randconfig-a002-20220801
i386                 randconfig-a004-20220801

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
