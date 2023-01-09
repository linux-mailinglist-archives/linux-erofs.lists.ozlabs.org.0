Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E271662A8C
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Jan 2023 16:52:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NrJNf1sBJz3cBC
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Jan 2023 02:52:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+uL4AVp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+uL4AVp;
	dkim-atps=neutral
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NrJNX0HTMz3bT5
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Jan 2023 02:52:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673279532; x=1704815532;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M5Vpr5Yya9kaYqoNur4Rhl6vbDiLebNqbLW22ZhYgUU=;
  b=F+uL4AVp3h6o0h/ZsskzOV7jTcpCRIhaoMjOtcrf6aJr+CkYRoOAIULq
   RbXnLebqJ2rONzszCEaaSzOuwsCOPeIcmBUW08APRcAP+Wy/dfedXnvys
   J145Wq4XBbHr4w2BCxGIHHJ17bnVuC0ttaBZ68fLfHES1R9URra3ei0KX
   1iGaWyknUnvmWjQV0UV3DD4McM5hp8JZqLvwA/POEv4Db+DsND0iHWeL4
   GSVlvU/+uThA2Vwx5N54ecSPWFUcOb4vRHyb6712Hw3jEIk1fGt+Wn8Vh
   UtyOVm0kuLudYk4VNoMo33/GE+mLJMQX1XjWYh4iS+olUE9KsfAXE5fEs
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350117717"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="350117717"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 07:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="985430809"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="985430809"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2023 07:52:02 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pEuRN-0006xM-10;
	Mon, 09 Jan 2023 15:52:01 +0000
Date: Mon, 09 Jan 2023 23:51:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 722f5debea5c7e7c479c3b95e4bd63d2468a8660
Message-ID: <63bc380b.K/hyDay2Pz89eY/H%lkp@intel.com>
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
branch HEAD: 722f5debea5c7e7c479c3b95e4bd63d2468a8660  erofs: fix kvcalloc() misuse with __GFP_NOFAIL

elapsed time: 722m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
arc                                 defconfig
powerpc                           allnoconfig
s390                             allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                             allnoconfig
x86_64                            allnoconfig
i386                              allnoconfig
arm                               allnoconfig
ia64                             allmodconfig
arc                               allnoconfig
x86_64                              defconfig
arm                                 defconfig
arm64                            allyesconfig
s390                                defconfig
x86_64               randconfig-a012-20230109
i386                 randconfig-a014-20230109
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a016-20230109
x86_64               randconfig-a014-20230109
i386                                defconfig
arm                              allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a011-20230109
x86_64               randconfig-a011-20230109
x86_64               randconfig-a013-20230109
sh                               allmodconfig
x86_64                           allyesconfig
s390                             allyesconfig
powerpc                 mpc837x_rdb_defconfig
x86_64               randconfig-a015-20230109
m68k                             allyesconfig
i386                 randconfig-a016-20230109
arm                  randconfig-r046-20230108
i386                          randconfig-a014
m68k                             allmodconfig
arm                        oxnas_v6_defconfig
i386                 randconfig-a015-20230109
mips                             allyesconfig
x86_64                           rhel-8.3-bpf
arc                              allyesconfig
x86_64                           rhel-8.3-syz
i386                 randconfig-a013-20230109
i386                             allyesconfig
alpha                            allyesconfig
i386                 randconfig-a012-20230109
i386                          randconfig-a012
m68k                           sun3_defconfig
powerpc                          allmodconfig
i386                          randconfig-a016
sparc64                          alldefconfig
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20230109
arc                  randconfig-r043-20230108
x86_64                           rhel-8.3-kvm
arm                         s3c6400_defconfig
s390                 randconfig-r044-20230109
sh                          r7780mp_defconfig
arc                  randconfig-r043-20230109
sh                   sh7770_generic_defconfig
m68k                          hp300_defconfig
powerpc                      makalu_defconfig
powerpc                     tqm8548_defconfig
powerpc                   motionpro_defconfig
arm                        mvebu_v7_defconfig
arc                     haps_hs_smp_defconfig
sh                         apsh4a3a_defconfig
powerpc                     taishan_defconfig
parisc                           allyesconfig
riscv                             allnoconfig
arm                        mini2440_defconfig
powerpc                        warp_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
xtensa                       common_defconfig
powerpc                      mgcoge_defconfig
arm64                            alldefconfig
mips                         cobalt_defconfig
mips                  maltasmvp_eva_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                          iop32x_defconfig
m68k                       bvme6000_defconfig
arm                        multi_v7_defconfig
openrisc                       virt_defconfig
xtensa                generic_kc705_defconfig

clang tested configs:
i386                 randconfig-a004-20230109
i386                 randconfig-a002-20230109
i386                 randconfig-a003-20230109
i386                 randconfig-a001-20230109
x86_64                          rhel-8.3-rust
x86_64               randconfig-a005-20230109
i386                 randconfig-a006-20230109
i386                 randconfig-a005-20230109
x86_64               randconfig-a003-20230109
x86_64               randconfig-a006-20230109
x86_64               randconfig-a002-20230109
hexagon              randconfig-r045-20230108
x86_64               randconfig-a004-20230109
arm                        neponset_defconfig
hexagon              randconfig-r045-20230109
x86_64               randconfig-a001-20230109
arm                  randconfig-r046-20230109
i386                          randconfig-a013
i386                          randconfig-a011
mips                        qi_lb60_defconfig
hexagon              randconfig-r041-20230109
i386                          randconfig-a015
riscv                randconfig-r042-20230108
hexagon              randconfig-r041-20230108
s390                 randconfig-r044-20230108
arm                          ep93xx_defconfig
arm                      tct_hammer_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           spitz_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
