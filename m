Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19982F2EA
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jan 2024 18:10:45 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HyPMkN3c;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TDwWL0Swtz3bnK
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jan 2024 04:10:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HyPMkN3c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TDwW753H6z2xQD
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jan 2024 04:10:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705425028; x=1736961028;
  h=date:from:to:cc:subject:message-id;
  bh=DpHC1Pnu+WAnsscjlR4LOY/s9VbHAbRiGqMea5hYSV4=;
  b=HyPMkN3c0Ex5IIlxbjfw1+l+1eL/7xSD+4mPw4WbTaAOHxSsNrmfQbi2
   MyQAcY3G13jMZdNFphPFz34El+yPXicDNUWambjf0QPtjn9lrT8JJN4SE
   oWcyiP7THg61/fRRao1wDE/OLStD6cgk9oVnFSBSOzoN2eymvIVo8FqO3
   r8CqFmDXXIzvgDzdY6iKDpL26ILesb5qFn0/fcdHYUOfwdrqoy+Rv0Wjt
   Fa2es8C+FEn9AcUXahqka8ur21ZQm9hKmCbZ2BLnExbEIBuyyEaKiPW31
   h64wrSGmJg/6awwdL6XGTiTEoKTzzcS/LTIHXNiqwkNGk5foGSNtXwySD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="21398775"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="21398775"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 09:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="874523463"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="874523463"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2024 09:09:19 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPmw9-0000yM-0k;
	Tue, 16 Jan 2024 17:09:17 +0000
Date: Wed, 17 Jan 2024 01:09:05 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 2b872b0f466d2acb4491da845c66b49246d5cdf9
Message-ID: <202401170103.AjQFWT4A-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: 2b872b0f466d2acb4491da845c66b49246d5cdf9  erofs: Don't use certain unnecessary folio_*() functions

elapsed time: 1463m

configs tested: 162
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240116   gcc  
arc                   randconfig-002-20240116   gcc  
arm                               allnoconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240116   clang
arm                   randconfig-002-20240116   clang
arm                   randconfig-003-20240116   clang
arm                   randconfig-004-20240116   clang
arm                             rpc_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240116   clang
arm64                 randconfig-002-20240116   clang
arm64                 randconfig-003-20240116   clang
arm64                 randconfig-004-20240116   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240116   gcc  
csky                  randconfig-002-20240116   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
hexagon               randconfig-001-20240116   clang
hexagon               randconfig-002-20240116   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240116   clang
i386         buildonly-randconfig-002-20240116   clang
i386         buildonly-randconfig-003-20240116   clang
i386         buildonly-randconfig-004-20240116   clang
i386         buildonly-randconfig-005-20240116   clang
i386         buildonly-randconfig-006-20240116   clang
i386                  randconfig-001-20240116   clang
i386                  randconfig-002-20240116   clang
i386                  randconfig-003-20240116   clang
i386                  randconfig-004-20240116   clang
i386                  randconfig-005-20240116   clang
i386                  randconfig-006-20240116   clang
i386                  randconfig-011-20240116   gcc  
i386                  randconfig-012-20240116   gcc  
i386                  randconfig-013-20240116   gcc  
i386                  randconfig-014-20240116   gcc  
i386                  randconfig-015-20240116   gcc  
i386                  randconfig-016-20240116   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240116   gcc  
loongarch             randconfig-002-20240116   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240116   gcc  
nios2                 randconfig-002-20240116   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240116   gcc  
parisc                randconfig-002-20240116   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc               randconfig-001-20240116   clang
powerpc               randconfig-002-20240116   clang
powerpc               randconfig-003-20240116   clang
powerpc                     redwood_defconfig   gcc  
powerpc64             randconfig-001-20240116   clang
powerpc64             randconfig-002-20240116   clang
powerpc64             randconfig-003-20240116   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240116   clang
riscv                 randconfig-002-20240116   clang
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240116   gcc  
s390                  randconfig-002-20240116   gcc  
sh                                allnoconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240116   gcc  
sh                    randconfig-002-20240116   gcc  
sh                          rsk7264_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240116   gcc  
sparc64               randconfig-002-20240116   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240116   clang
um                    randconfig-002-20240116   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240116   clang
x86_64       buildonly-randconfig-002-20240116   clang
x86_64       buildonly-randconfig-003-20240116   clang
x86_64       buildonly-randconfig-004-20240116   clang
x86_64       buildonly-randconfig-005-20240116   clang
x86_64       buildonly-randconfig-006-20240116   clang
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240116   clang
x86_64                randconfig-012-20240116   clang
x86_64                randconfig-013-20240116   clang
x86_64                randconfig-014-20240116   clang
x86_64                randconfig-015-20240116   clang
x86_64                randconfig-016-20240116   clang
x86_64                randconfig-071-20240116   clang
x86_64                randconfig-072-20240116   clang
x86_64                randconfig-073-20240116   clang
x86_64                randconfig-074-20240116   clang
x86_64                randconfig-075-20240116   clang
x86_64                randconfig-076-20240116   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240116   gcc  
xtensa                randconfig-002-20240116   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
