Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCDE66D4E4
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jan 2023 04:11:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nwv6c75P1z3c9Q
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jan 2023 14:11:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KAmxKTMO;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KAmxKTMO;
	dkim-atps=neutral
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nwv6Y2XCQz30CT
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jan 2023 14:11:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673925061; x=1705461061;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=XjBAI5ApN6JqrguVZ7MHvDLMBfNhxWfovqd86OlToHQ=;
  b=KAmxKTMOFgNpLZlSufuKtyxUyA9bHZRDIH5L3Boy6ywrTBPhd5V9HRRf
   qJ7P0uI6s7YubHoCO6E9siuceCLGDojWaJU16yn5lszMSPdQAISXLzOrd
   fGh2a0bygSezNiObspIlYlMRYGysm3spN1v/odDZ6rvwkb/TANrq2M+5G
   VFJws/+Q3z+iN8B7cWITR0v+S1oMBs0zuGPYtfECA2wTC5sp1+OLUbgHN
   Z2cZPxRPJ5rey++RCOGtfs4rzvBkgnLC6skevYb9/vjTrAgf9sTQHRxY9
   T/PDirfZgG936ppFyf0QBqtW0QpHlNAOQHmsW8E9aceK28CwjLvGvzyxO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326666098"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="326666098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 19:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659235188"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="659235188"
Received: from lkp-server02.sh.intel.com (HELO f57cd993bc73) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Jan 2023 19:10:54 -0800
Received: from kbuild by f57cd993bc73 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pHcNB-0000u6-1q;
	Tue, 17 Jan 2023 03:10:53 +0000
Date: Tue, 17 Jan 2023 11:10:00 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 e02ac3e7329f76c5de40cba2746cbe165f571dff
Message-ID: <63c61188.4OnrhSs5rm/GnDoR%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git fixes
branch HEAD: e02ac3e7329f76c5de40cba2746cbe165f571dff  erofs: clean up parsing of fscache related options

elapsed time: 723m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
arc                               allnoconfig
alpha                             allnoconfig
i386                              allnoconfig
arm                               allnoconfig
x86_64               randconfig-a011-20230116
x86_64               randconfig-a016-20230116
x86_64               randconfig-a014-20230116
x86_64               randconfig-a013-20230116
x86_64               randconfig-a015-20230116
x86_64               randconfig-a012-20230116
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
ia64                             allmodconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a013-20230116
i386                 randconfig-a012-20230116
i386                 randconfig-a016-20230116
i386                 randconfig-a014-20230116
i386                 randconfig-a015-20230116
i386                 randconfig-a011-20230116
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
mips                           jazz_defconfig
powerpc                      ep88xc_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
sh                        sh7785lcr_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                        bcm47xx_defconfig
mips                         bigsur_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                       ppc64_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc834x_itx_defconfig
riscv                            allyesconfig
powerpc                       holly_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                  iss476-smp_defconfig
sh                         apsh4a3a_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
m68k                         apollo_defconfig
um                               alldefconfig
mips                         db1xxx_defconfig
powerpc                 mpc837x_rdb_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                randconfig-r042-20230116
arm                  randconfig-r046-20230117
s390                 randconfig-r044-20230116
arc                  randconfig-r043-20230117
arc                  randconfig-r043-20230116
i386                 randconfig-c001-20230116
sh                        sh7763rdp_defconfig
sh                         ap325rxa_defconfig
alpha                            alldefconfig
arc                         haps_hs_defconfig

clang tested configs:
x86_64               randconfig-a003-20230116
x86_64               randconfig-a004-20230116
x86_64               randconfig-a006-20230116
x86_64               randconfig-a005-20230116
x86_64               randconfig-a001-20230116
x86_64               randconfig-a002-20230116
i386                 randconfig-a002-20230116
i386                 randconfig-a004-20230116
i386                 randconfig-a001-20230116
i386                 randconfig-a003-20230116
i386                 randconfig-a005-20230116
i386                 randconfig-a006-20230116
arm                        vexpress_defconfig
powerpc                 mpc8315_rdb_defconfig
riscv                randconfig-r042-20230115
arm                  randconfig-r046-20230116
s390                 randconfig-r044-20230115
hexagon              randconfig-r041-20230115
hexagon              randconfig-r041-20230116
hexagon              randconfig-r045-20230115
hexagon              randconfig-r045-20230116
arm                          pxa168_defconfig
arm                     am200epdkit_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
i386                              allnoconfig
powerpc                   lite5200b_defconfig
mips                  cavium_octeon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
