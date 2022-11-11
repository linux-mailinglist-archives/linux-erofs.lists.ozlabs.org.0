Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181E624FFC
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Nov 2022 03:06:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N7hrr1x5Qz3cMm
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Nov 2022 13:06:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QB/RUAmP;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QB/RUAmP;
	dkim-atps=neutral
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N7hrk0xnFz3cBq
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Nov 2022 13:06:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668132374; x=1699668374;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=URxWC7t0t4CZNNeLUlYSkZBGjbhs/ezYP8MGF7xH59g=;
  b=QB/RUAmPUx1Nd6tCMTBnGdDeIN14iQFMwvJEcYNWgSERLweeUf+Xakx0
   QOaF9FCjpTfpEAiEJ1t4GVPFJou7RmeRwl1DNEidPfWGBIi3MczzodwbF
   0aRSP+azW1gHN9cEMM5X43+iB1drVchBNry7SqnZzJ4Tlnme42MDYKG+s
   JcZOx+r6gSv++T39BiNhuUE2ZyxAhvJ5Ocd8nF0GzFWzIMuUN+4Elz7nA
   SVMEVq5OA2EPH/jXa3my5QBZPKoyAIcjNnf9jXenyTHtusBs5NGL9uQ8f
   4uBTIvW42aw1rbRMncylFSnl0m2aE6fG696HG6kT4HJ2/i/IWGM8F7Wt+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373626701"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="373626701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668652349"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="668652349"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2022 18:04:48 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1otJPT-0003S1-2K;
	Fri, 11 Nov 2022 02:04:47 +0000
Date: Fri, 11 Nov 2022 10:03:59 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 39bfcb8138f6dc3375f23b1e62ccfc7c0d83295d
Message-ID: <636dad8f.ycUMa+AurZrizsXu%lkp@intel.com>
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
branch HEAD: 39bfcb8138f6dc3375f23b1e62ccfc7c0d83295d  erofs: fix use-after-free of fsid and domain_id string

elapsed time: 1447m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                             allnoconfig
i386                              allnoconfig
sh                               allmodconfig
arm                               allnoconfig
arc                               allnoconfig
powerpc                           allnoconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arc                                 defconfig
alpha                               defconfig
i386                          randconfig-a001
i386                          randconfig-a003
um                             i386_defconfig
i386                          randconfig-a005
um                           x86_64_defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                              defconfig
x86_64                            allnoconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
powerpc                     sequoia_defconfig
mips                         cobalt_defconfig
x86_64                               rhel-8.3
arm                      footbridge_defconfig
xtensa                  cadence_csp_defconfig
mips                         db1xxx_defconfig
arm                        spear6xx_defconfig
powerpc                      pasemi_defconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
s390                             allyesconfig
x86_64                           allyesconfig
i386                                defconfig
m68k                             allyesconfig
i386                             allyesconfig
ia64                             allmodconfig
sh                           se7722_defconfig
arm                         cm_x300_defconfig
powerpc              randconfig-c003-20221110
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
mips                             allyesconfig
powerpc                          allmodconfig
sh                   secureedge5410_defconfig
powerpc                 mpc837x_rdb_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
microblaze                          defconfig
parisc                           alldefconfig
arm                          pxa910_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm64                               defconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
loongarch                           defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                             rpc_defconfig
m68k                          multi_defconfig
arc                         haps_hs_defconfig
powerpc                    amigaone_defconfig
arc                        nsimosci_defconfig
powerpc                       ppc64_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-c001
xtensa                           alldefconfig
parisc                generic-32bit_defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
ia64                        generic_defconfig
openrisc                         alldefconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                     taishan_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         vf610m4_defconfig
riscv                             allnoconfig
xtensa                           allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
s390                 randconfig-r044-20221110
riscv                randconfig-r042-20221110
hexagon              randconfig-r041-20221110
hexagon              randconfig-r045-20221110
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a001
powerpc                        fsp2_defconfig
powerpc                    gamecube_defconfig
mips                malta_qemu_32r6_defconfig
mips                     loongson2k_defconfig
riscv                             allnoconfig
x86_64                        randconfig-k001
hexagon              randconfig-r041-20221111
hexagon              randconfig-r045-20221111
arm                        vexpress_defconfig
powerpc                    mvme5100_defconfig
arm                       versatile_defconfig
riscv                randconfig-c006-20221110
x86_64                        randconfig-c007
mips                 randconfig-c004-20221110
i386                          randconfig-c001
arm                  randconfig-c002-20221110
powerpc              randconfig-c003-20221110
s390                 randconfig-c005-20221110
arm                       aspeed_g4_defconfig
mips                      pic32mzda_defconfig
arm                         lpc32xx_defconfig
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
