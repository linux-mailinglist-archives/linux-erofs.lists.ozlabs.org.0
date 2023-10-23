Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBB7D3927
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Oct 2023 16:19:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b2Vc8SKh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SDckg4yYWz3bv3
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Oct 2023 01:19:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b2Vc8SKh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SDckX1MwXz2xYt
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Oct 2023 01:18:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698070740; x=1729606740;
  h=date:from:to:cc:subject:message-id;
  bh=2RF+C9B9sqDrxLGkdfx8o6mLxWKuKnPD24Qp5MuiQfs=;
  b=b2Vc8SKh3DFkPiMh5/3l4dJxl01by+04GXZKu6nx71B6SOt0Jfnuxxmu
   oBLwoQMLRpyU6Ni2R81ohYTLsv0W5x/5YuvSeAyO7l5le+3m1qNOTHJr+
   3tgEB2wCo+o/oQ+e2XE/ZXzR2r2gPP8iTCsK30rJ/bpbg+sR1UX7l3MDo
   y3aVhr9gQsvSEo3r6IbFSF5wGcciMN6YlsyUT1a70WPCM4yTZh8YRuhPw
   TSquz/wBO1D416PHOT89meclJ35PqNcdYcpGL+n/dGo5Q6YnOT3wRLDOH
   6491iuYIXpLh+bm9eZa/EfHzpFO1cdlK678Uc00rUR7vZLoJfLMGOoUSB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8404262"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8404262"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="901808790"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="901808790"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2023 07:16:36 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1quvlb-0006yH-2Q;
	Mon, 23 Oct 2023 14:18:51 +0000
Date: Mon, 23 Oct 2023 22:18:13 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 07ab480161171a81fa92bf518606cff4ee9ccdd6
Message-ID: <202310232209.fCRz2URg-lkp@intel.com>
User-Agent: s-nail v14.9.24
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
branch HEAD: 07ab480161171a81fa92bf518606cff4ee9ccdd6  erofs: simplify compression configuration parser

elapsed time: 1472m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231022   gcc  
arc                   randconfig-001-20231023   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231023   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231023   gcc  
i386         buildonly-randconfig-002-20231023   gcc  
i386         buildonly-randconfig-003-20231023   gcc  
i386         buildonly-randconfig-004-20231023   gcc  
i386         buildonly-randconfig-005-20231023   gcc  
i386         buildonly-randconfig-006-20231023   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231023   gcc  
i386                  randconfig-002-20231023   gcc  
i386                  randconfig-003-20231023   gcc  
i386                  randconfig-004-20231023   gcc  
i386                  randconfig-005-20231023   gcc  
i386                  randconfig-006-20231023   gcc  
i386                  randconfig-011-20231023   gcc  
i386                  randconfig-012-20231023   gcc  
i386                  randconfig-013-20231023   gcc  
i386                  randconfig-014-20231023   gcc  
i386                  randconfig-015-20231023   gcc  
i386                  randconfig-016-20231023   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231022   gcc  
loongarch             randconfig-001-20231023   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                          g5_defconfig   clang
powerpc                        icon_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231023   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231023   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231023   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231023   gcc  
x86_64       buildonly-randconfig-002-20231023   gcc  
x86_64       buildonly-randconfig-003-20231023   gcc  
x86_64       buildonly-randconfig-004-20231023   gcc  
x86_64       buildonly-randconfig-005-20231023   gcc  
x86_64       buildonly-randconfig-006-20231023   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231023   gcc  
x86_64                randconfig-002-20231023   gcc  
x86_64                randconfig-003-20231023   gcc  
x86_64                randconfig-004-20231023   gcc  
x86_64                randconfig-005-20231023   gcc  
x86_64                randconfig-006-20231023   gcc  
x86_64                randconfig-011-20231023   gcc  
x86_64                randconfig-012-20231023   gcc  
x86_64                randconfig-013-20231023   gcc  
x86_64                randconfig-014-20231023   gcc  
x86_64                randconfig-015-20231023   gcc  
x86_64                randconfig-016-20231023   gcc  
x86_64                randconfig-071-20231023   gcc  
x86_64                randconfig-072-20231023   gcc  
x86_64                randconfig-073-20231023   gcc  
x86_64                randconfig-074-20231023   gcc  
x86_64                randconfig-075-20231023   gcc  
x86_64                randconfig-076-20231023   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
