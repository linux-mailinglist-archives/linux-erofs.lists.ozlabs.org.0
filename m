Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4C621D86
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Nov 2022 21:18:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N6KD23Mrtz3f33
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Nov 2022 07:18:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U/86R9N0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U/86R9N0;
	dkim-atps=neutral
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N6KBw32J9z3cJt
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Nov 2022 07:17:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667938632; x=1699474632;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oSxCbUR46wf41NVrdAhEcC6SB8ft3nBzE/tuq1hDpAY=;
  b=U/86R9N0pv4on1TuIJHH+fVhZH+CudsmEEb/Mrr/taIgvPS37QtT7qUl
   bDxe68E+94JP5RnntE6jsgPKE1pyPyq/ximvEbPjf3I0NFc6cQbuG11N+
   7nepHxji8l/Gy5/j9f509egfOeI0vSDPUSZHsPeMqGKj/nnUo03YgjsrW
   S+yozIKQQofDQBXYaT7rZMCKQmaiunheAkj4yTNxrk5grcu6uayg+aWAL
   BXlNRrqPnfGOdiAgvYz7hZ6TDrTZF3sOUjFelcapd+pj6NknDiFhYxKhD
   T2IwvdJ0YBoW9lmqp1XNZw5k3hgrZUaii8HEpkhExYSedzYqwJBI+8pUs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298316072"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298316072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 12:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669680823"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669680823"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2022 12:17:00 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1osV1n-0000Zc-1Q;
	Tue, 08 Nov 2022 20:16:59 +0000
Date: Wed, 09 Nov 2022 04:16:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 9473d22fbfca38a12d7182ca91a0a8bc193a72bf
Message-ID: <636ab910.dW9fWvfSI5776UCm%lkp@intel.com>
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
branch HEAD: 9473d22fbfca38a12d7182ca91a0a8bc193a72bf  erofs: fix use-after-free of fsid and domain_id string

elapsed time: 720m

configs tested: 144
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                              defconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
arc                                 defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                           allyesconfig
s390                             allmodconfig
alpha                             allnoconfig
i386                              allnoconfig
arc                               allnoconfig
arm                               allnoconfig
s390                                defconfig
arc                  randconfig-r043-20221108
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
riscv                randconfig-r042-20221108
s390                 randconfig-r044-20221108
i386                          randconfig-a003
i386                          randconfig-a001
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a005
s390                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
arm                      footbridge_defconfig
arm                           tegra_defconfig
sh                           sh2007_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
i386                             allyesconfig
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20221107
i386                 randconfig-a006-20221107
i386                 randconfig-a003-20221107
i386                 randconfig-a002-20221107
i386                 randconfig-a005-20221107
i386                 randconfig-a004-20221107
powerpc                        warp_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
i386                                defconfig
x86_64               randconfig-a006-20221107
x86_64               randconfig-a001-20221107
x86_64               randconfig-a004-20221107
x86_64               randconfig-a003-20221107
x86_64               randconfig-a005-20221107
x86_64               randconfig-a002-20221107
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
powerpc                         ps3_defconfig
arm                           viper_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
openrisc                    or1ksim_defconfig
powerpc                      ppc40x_defconfig
alpha                            alldefconfig
mips                        vocore2_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
arm                             pxa_defconfig
sh                            titan_defconfig
mips                  decstation_64_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                               defconfig
riscv                             allnoconfig
sh                          rsk7203_defconfig
powerpc                     asp8347_defconfig
nios2                            alldefconfig
powerpc                    sam440ep_defconfig
arm                             ezx_defconfig
sh                        edosk7705_defconfig
i386                          randconfig-c001
arc                              alldefconfig
sh                           se7751_defconfig
powerpc                 linkstation_defconfig
sh                           se7206_defconfig
ia64                         bigsur_defconfig
sh                          rsk7269_defconfig
arm                        shmobile_defconfig
arm                         at91_dt_defconfig
mips                      loongson3_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
powerpc                       holly_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                             rpc_defconfig
sparc                       sparc32_defconfig
arm                          exynos_defconfig
mips                          rb532_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        cerfcube_defconfig
arm                       aspeed_g5_defconfig
parisc                generic-32bit_defconfig
mips                           xway_defconfig

clang tested configs:
hexagon              randconfig-r041-20221108
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221108
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                     tqm8560_defconfig
arm                           omap1_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-k001
arm64                            allyesconfig
riscv                randconfig-r042-20221107
hexagon              randconfig-r041-20221107
hexagon              randconfig-r045-20221107
s390                 randconfig-r044-20221107

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
