Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FC1196A33
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2020 01:16:48 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48qbk3738czDqgx
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2020 11:16:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48qbjs1gHyzDqX2
 for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2020 11:16:25 +1100 (AEDT)
IronPort-SDR: wi7Z3TpMM9ZZytGMjzH/JHuA4uGfbD0ferpA5KYfw7J6e3BU/zHv8x8RQ8nF/iIIhpgcjuiSf2
 sAPU8metR2NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2020 17:16:20 -0700
IronPort-SDR: j96yk62cPrMg2TwPd/LjTDpA6UaqVqJtuNvmNzoiAXVGDgblnszgp9gpoxG+ehkRNLSRxykU1e
 a+Hjb1Ee9K+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,318,1580803200"; d="scan'208";a="251508243"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga006.jf.intel.com with ESMTP; 28 Mar 2020 17:16:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1jILcg-0005Kx-AZ; Sun, 29 Mar 2020 08:16:18 +0800
Date: Sun, 29 Mar 2020 08:15:30 +0800
From: kbuild test robot <lkp@intel.com>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: [xiang-erofs:dev] BUILD SUCCESS
 20741a6e146cab59745c7f25abf49d891a83f8e9
Message-ID: <5e7fe8a2.CjyjLM6dq2g5m1fd%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  dev
branch HEAD: 20741a6e146cab59745c7f25abf49d891a83f8e9  MAINTAINERS: erofs: update my email address

elapsed time: 1004m

configs tested: 199
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
parisc                generic-64bit_defconfig
arm                          exynos_defconfig
nios2                         10m50_defconfig
ia64                             alldefconfig
microblaze                      mmu_defconfig
parisc                generic-32bit_defconfig
ia64                                defconfig
m68k                          multi_defconfig
riscv                            allmodconfig
sparc                               defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
s390                             alldefconfig
sparc64                           allnoconfig
i386                                defconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         3c120_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                       m5475evb_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
parisc                            allnoconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200327
x86_64               randconfig-a002-20200327
x86_64               randconfig-a003-20200327
i386                 randconfig-a001-20200327
i386                 randconfig-a002-20200327
i386                 randconfig-a003-20200327
alpha                randconfig-a001-20200329
m68k                 randconfig-a001-20200329
mips                 randconfig-a001-20200329
nds32                randconfig-a001-20200329
parisc               randconfig-a001-20200329
riscv                randconfig-a001-20200329
c6x                  randconfig-a001-20200327
h8300                randconfig-a001-20200327
microblaze           randconfig-a001-20200327
nios2                randconfig-a001-20200327
sparc64              randconfig-a001-20200327
c6x                  randconfig-a001-20200329
h8300                randconfig-a001-20200329
microblaze           randconfig-a001-20200329
nios2                randconfig-a001-20200329
sparc64              randconfig-a001-20200329
x86_64               randconfig-b001-20200327
x86_64               randconfig-b002-20200327
x86_64               randconfig-b003-20200327
i386                 randconfig-b001-20200327
i386                 randconfig-b002-20200327
i386                 randconfig-b003-20200327
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c001-20200329
i386                 randconfig-c002-20200329
i386                 randconfig-c003-20200329
x86_64               randconfig-c003-20200327
x86_64               randconfig-c001-20200327
i386                 randconfig-c002-20200327
x86_64               randconfig-c002-20200327
i386                 randconfig-c001-20200327
i386                 randconfig-c003-20200327
x86_64               randconfig-d001-20200327
x86_64               randconfig-d002-20200327
x86_64               randconfig-d003-20200327
i386                 randconfig-d001-20200327
i386                 randconfig-d002-20200327
i386                 randconfig-d003-20200327
x86_64               randconfig-d001-20200329
x86_64               randconfig-d002-20200329
x86_64               randconfig-d003-20200329
i386                 randconfig-d001-20200329
i386                 randconfig-d002-20200329
i386                 randconfig-d003-20200329
x86_64               randconfig-e001-20200328
x86_64               randconfig-e002-20200328
x86_64               randconfig-e003-20200328
i386                 randconfig-e001-20200328
i386                 randconfig-e002-20200328
i386                 randconfig-e003-20200328
x86_64               randconfig-e001-20200329
x86_64               randconfig-e002-20200329
x86_64               randconfig-e003-20200329
i386                 randconfig-e001-20200329
i386                 randconfig-e002-20200329
i386                 randconfig-e003-20200329
x86_64               randconfig-e001-20200327
x86_64               randconfig-e003-20200327
i386                 randconfig-e002-20200327
i386                 randconfig-e003-20200327
i386                 randconfig-e001-20200327
x86_64               randconfig-e002-20200327
x86_64               randconfig-f001-20200327
x86_64               randconfig-f002-20200327
x86_64               randconfig-f003-20200327
i386                 randconfig-f001-20200327
i386                 randconfig-f002-20200327
i386                 randconfig-f003-20200327
x86_64               randconfig-g001-20200327
x86_64               randconfig-g002-20200327
x86_64               randconfig-g003-20200327
i386                 randconfig-g001-20200327
i386                 randconfig-g002-20200327
i386                 randconfig-g003-20200327
x86_64               randconfig-g001-20200328
x86_64               randconfig-g002-20200328
x86_64               randconfig-g003-20200328
i386                 randconfig-g001-20200328
i386                 randconfig-g002-20200328
i386                 randconfig-g003-20200328
x86_64               randconfig-h001-20200327
x86_64               randconfig-h002-20200327
x86_64               randconfig-h003-20200327
i386                 randconfig-h001-20200327
i386                 randconfig-h002-20200327
i386                 randconfig-h003-20200327
x86_64               randconfig-h001-20200329
x86_64               randconfig-h002-20200329
x86_64               randconfig-h003-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
i386                 randconfig-h003-20200329
sparc                randconfig-a001-20200327
arm                  randconfig-a001-20200327
powerpc              randconfig-a001-20200327
ia64                 randconfig-a001-20200327
arc                  randconfig-a001-20200327
arm64                randconfig-a001-20200327
arc                  randconfig-a001-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
powerpc              randconfig-a001-20200329
sparc                randconfig-a001-20200329
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                             allyesconfig
sparc64                             defconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
i386                             alldefconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
