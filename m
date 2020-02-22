Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC1168CE6
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 07:41:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Pdz82ScQzDqgC
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Feb 2020 17:41:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Pdyz447ZzDqRX
 for <linux-erofs@lists.ozlabs.org>; Sat, 22 Feb 2020 17:41:39 +1100 (AEDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Feb 2020 22:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; d="scan'208";a="229400081"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2020 22:41:33 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1j5OTl-00081v-BN; Sat, 22 Feb 2020 14:41:33 +0800
Date: Sat, 22 Feb 2020 14:41:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 f4ae4be738bf5c43ad009f654e4776fb9112786c
Message-ID: <5e50cd11.WQCPCCYpT0UkRBnm%lkp@intel.com>
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
Cc: Xiang Gao <xiang@kernel.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev-test
branch HEAD: f4ae4be738bf5c43ad009f654e4776fb9112786c  erofs: convert workstn to XArray

elapsed time: 2706m

configs tested: 320
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
s390                             allmodconfig
s390                             allyesconfig
nds32                             allnoconfig
riscv                            allyesconfig
h8300                    h8300h-sim_defconfig
powerpc                             defconfig
sh                               allmodconfig
sparc64                             defconfig
mips                              allnoconfig
csky                                defconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
nios2                         10m50_defconfig
sparc                               defconfig
m68k                           sun3_defconfig
s390                       zfcpdump_defconfig
sh                            titan_defconfig
xtensa                          iss_defconfig
microblaze                      mmu_defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
ia64                              allnoconfig
i386                                defconfig
x86_64                            allnoconfig
m68k                          multi_defconfig
openrisc                    or1ksim_defconfig
s390                                defconfig
arc                                 defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200220
x86_64               randconfig-a002-20200220
x86_64               randconfig-a003-20200220
i386                 randconfig-a001-20200220
i386                 randconfig-a002-20200220
i386                 randconfig-a003-20200220
x86_64               randconfig-a001-20200221
x86_64               randconfig-a002-20200221
x86_64               randconfig-a003-20200221
i386                 randconfig-a001-20200221
i386                 randconfig-a002-20200221
i386                 randconfig-a003-20200221
x86_64               randconfig-a001-20200219
x86_64               randconfig-a002-20200219
x86_64               randconfig-a003-20200219
i386                 randconfig-a001-20200219
i386                 randconfig-a002-20200219
i386                 randconfig-a003-20200219
alpha                randconfig-a001-20200221
m68k                 randconfig-a001-20200221
mips                 randconfig-a001-20200221
nds32                randconfig-a001-20200221
parisc               randconfig-a001-20200221
riscv                randconfig-a001-20200221
alpha                randconfig-a001-20200222
m68k                 randconfig-a001-20200222
mips                 randconfig-a001-20200222
nds32                randconfig-a001-20200222
parisc               randconfig-a001-20200222
riscv                randconfig-a001-20200222
alpha                randconfig-a001-20200220
m68k                 randconfig-a001-20200220
mips                 randconfig-a001-20200220
nds32                randconfig-a001-20200220
parisc               randconfig-a001-20200220
riscv                randconfig-a001-20200220
alpha                randconfig-a001-20200219
m68k                 randconfig-a001-20200219
nds32                randconfig-a001-20200219
parisc               randconfig-a001-20200219
riscv                randconfig-a001-20200219
c6x                  randconfig-a001-20200221
h8300                randconfig-a001-20200221
microblaze           randconfig-a001-20200221
nios2                randconfig-a001-20200221
sparc64              randconfig-a001-20200221
c6x                  randconfig-a001-20200220
h8300                randconfig-a001-20200220
microblaze           randconfig-a001-20200220
nios2                randconfig-a001-20200220
sparc64              randconfig-a001-20200220
c6x                  randconfig-a001-20200222
h8300                randconfig-a001-20200222
microblaze           randconfig-a001-20200222
nios2                randconfig-a001-20200222
sparc64              randconfig-a001-20200222
csky                 randconfig-a001-20200219
openrisc             randconfig-a001-20200219
s390                 randconfig-a001-20200219
xtensa               randconfig-a001-20200219
csky                 randconfig-a001-20200221
openrisc             randconfig-a001-20200221
s390                 randconfig-a001-20200221
sh                   randconfig-a001-20200221
xtensa               randconfig-a001-20200221
csky                 randconfig-a001-20200220
openrisc             randconfig-a001-20200220
s390                 randconfig-a001-20200220
sh                   randconfig-a001-20200220
xtensa               randconfig-a001-20200220
csky                 randconfig-a001-20200222
openrisc             randconfig-a001-20200222
s390                 randconfig-a001-20200222
sh                   randconfig-a001-20200222
xtensa               randconfig-a001-20200222
x86_64               randconfig-b001-20200220
x86_64               randconfig-b002-20200220
x86_64               randconfig-b003-20200220
i386                 randconfig-b001-20200220
i386                 randconfig-b002-20200220
i386                 randconfig-b003-20200220
x86_64               randconfig-b001-20200221
x86_64               randconfig-b002-20200221
x86_64               randconfig-b003-20200221
i386                 randconfig-b001-20200221
i386                 randconfig-b002-20200221
i386                 randconfig-b003-20200221
x86_64               randconfig-b001-20200222
x86_64               randconfig-b002-20200222
x86_64               randconfig-b003-20200222
i386                 randconfig-b001-20200222
i386                 randconfig-b002-20200222
i386                 randconfig-b003-20200222
x86_64               randconfig-b001-20200219
x86_64               randconfig-b002-20200219
x86_64               randconfig-b003-20200219
i386                 randconfig-b001-20200219
i386                 randconfig-b002-20200219
i386                 randconfig-b003-20200219
x86_64               randconfig-c001-20200220
x86_64               randconfig-c002-20200220
x86_64               randconfig-c003-20200220
i386                 randconfig-c001-20200220
i386                 randconfig-c002-20200220
i386                 randconfig-c003-20200220
x86_64               randconfig-c001-20200221
x86_64               randconfig-c002-20200221
x86_64               randconfig-c003-20200221
i386                 randconfig-c001-20200221
i386                 randconfig-c002-20200221
i386                 randconfig-c003-20200221
x86_64               randconfig-c001-20200222
x86_64               randconfig-c002-20200222
x86_64               randconfig-c003-20200222
i386                 randconfig-c001-20200222
i386                 randconfig-c002-20200222
i386                 randconfig-c003-20200222
x86_64               randconfig-d001-20200220
x86_64               randconfig-d002-20200220
x86_64               randconfig-d003-20200220
i386                 randconfig-d001-20200220
i386                 randconfig-d002-20200220
i386                 randconfig-d003-20200220
x86_64               randconfig-d001-20200221
x86_64               randconfig-d002-20200221
x86_64               randconfig-d003-20200221
i386                 randconfig-d001-20200221
i386                 randconfig-d002-20200221
i386                 randconfig-d003-20200221
x86_64               randconfig-d001-20200222
x86_64               randconfig-d002-20200222
x86_64               randconfig-d003-20200222
i386                 randconfig-d001-20200222
i386                 randconfig-d002-20200222
i386                 randconfig-d003-20200222
x86_64               randconfig-e001-20200220
x86_64               randconfig-e002-20200220
x86_64               randconfig-e003-20200220
i386                 randconfig-e001-20200220
i386                 randconfig-e002-20200220
i386                 randconfig-e003-20200220
x86_64               randconfig-e001-20200222
x86_64               randconfig-e002-20200222
x86_64               randconfig-e003-20200222
i386                 randconfig-e001-20200222
i386                 randconfig-e002-20200222
i386                 randconfig-e003-20200222
x86_64               randconfig-e001-20200219
x86_64               randconfig-e002-20200219
x86_64               randconfig-e003-20200219
i386                 randconfig-e001-20200219
i386                 randconfig-e002-20200219
i386                 randconfig-e003-20200219
x86_64               randconfig-e001-20200221
x86_64               randconfig-e002-20200221
x86_64               randconfig-e003-20200221
i386                 randconfig-e001-20200221
i386                 randconfig-e002-20200221
i386                 randconfig-e003-20200221
x86_64               randconfig-f001-20200220
x86_64               randconfig-f002-20200220
x86_64               randconfig-f003-20200220
i386                 randconfig-f001-20200220
i386                 randconfig-f002-20200220
i386                 randconfig-f003-20200220
x86_64               randconfig-f001-20200221
x86_64               randconfig-f002-20200221
x86_64               randconfig-f003-20200221
i386                 randconfig-f001-20200221
i386                 randconfig-f002-20200221
i386                 randconfig-f003-20200221
x86_64               randconfig-f001-20200222
x86_64               randconfig-f002-20200222
x86_64               randconfig-f003-20200222
i386                 randconfig-f001-20200222
i386                 randconfig-f002-20200222
i386                 randconfig-f003-20200222
x86_64               randconfig-g001-20200222
x86_64               randconfig-g002-20200222
x86_64               randconfig-g003-20200222
i386                 randconfig-g001-20200222
i386                 randconfig-g002-20200222
i386                 randconfig-g003-20200222
x86_64               randconfig-g001-20200220
x86_64               randconfig-g002-20200220
x86_64               randconfig-g003-20200220
i386                 randconfig-g001-20200220
i386                 randconfig-g002-20200220
i386                 randconfig-g003-20200220
x86_64               randconfig-g001-20200221
x86_64               randconfig-g002-20200221
x86_64               randconfig-g003-20200221
i386                 randconfig-g001-20200221
i386                 randconfig-g002-20200221
i386                 randconfig-g003-20200221
x86_64               randconfig-h001-20200221
x86_64               randconfig-h002-20200221
x86_64               randconfig-h003-20200221
i386                 randconfig-h001-20200221
i386                 randconfig-h002-20200221
i386                 randconfig-h003-20200221
x86_64               randconfig-h001-20200220
x86_64               randconfig-h002-20200220
x86_64               randconfig-h003-20200220
i386                 randconfig-h001-20200220
i386                 randconfig-h002-20200220
i386                 randconfig-h003-20200220
x86_64               randconfig-h001-20200222
x86_64               randconfig-h002-20200222
x86_64               randconfig-h003-20200222
i386                 randconfig-h001-20200222
i386                 randconfig-h002-20200222
i386                 randconfig-h003-20200222
arc                  randconfig-a001-20200221
arm                  randconfig-a001-20200221
arm64                randconfig-a001-20200221
ia64                 randconfig-a001-20200221
powerpc              randconfig-a001-20200221
sparc                randconfig-a001-20200221
arc                  randconfig-a001-20200220
arm                  randconfig-a001-20200220
arm64                randconfig-a001-20200220
ia64                 randconfig-a001-20200220
powerpc              randconfig-a001-20200220
sparc                randconfig-a001-20200220
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
s390                             alldefconfig
s390                              allnoconfig
s390                          debug_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                                  defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
