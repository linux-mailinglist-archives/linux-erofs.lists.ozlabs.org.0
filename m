Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F2688323231
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 21:38:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DlW9H41vtz3bcy
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Feb 2021 07:38:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
X-Greylist: delayed 64 seconds by postgrey-1.36 at boromir;
 Wed, 24 Feb 2021 07:38:41 AEDT
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DlW9F31GVz30Mm
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Feb 2021 07:38:41 +1100 (AEDT)
IronPort-SDR: zZe4PD/UH4kGdxik7U5//ekGUNU7k/HoE0OQEAcKVbiDUPhtrCCuM3nmRt5ltUatf5rYFkORgV
 smxnVB0sdEfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="164794445"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; d="scan'208";a="164794445"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2021 12:37:28 -0800
IronPort-SDR: mk9rMXiQU/i39k9wn8Vn+a2mHdZj8XAO78LMk3QP6qUTq6P65r5iiFbbTLrW9I7AfqhDNBc6I0
 ijDY3l4VgbUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; d="scan'208";a="441848014"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 23 Feb 2021 12:37:06 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lEeQW-0001Xe-Ft; Tue, 23 Feb 2021 20:37:00 +0000
Date: Wed, 24 Feb 2021 04:36:05 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 ddada3734cabbc0ce65b65391129a218a6d15e3e
Message-ID: <60356735.eKyUJXDs/3R5VO9y%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: ddada3734cabbc0ce65b65391129a218a6d15e3e  erofs: support adjust lz4 history window size

elapsed time: 721m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
arc                         haps_hs_defconfig
arm64                            alldefconfig
powerpc                     rainier_defconfig
arc                    vdk_hs38_smp_defconfig
arm                      pxa255-idp_defconfig
arm                         axm55xx_defconfig
m68k                         amcore_defconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
ia64                         bigsur_defconfig
powerpc                     tqm8560_defconfig
arc                          axs101_defconfig
arm                         s3c6400_defconfig
mips                           jazz_defconfig
arm                            pleb_defconfig
xtensa                           alldefconfig
arm                          moxart_defconfig
sh                          r7785rp_defconfig
mips                           xway_defconfig
mips                        qi_lb60_defconfig
arm                          pxa910_defconfig
arc                          axs103_defconfig
arm                        shmobile_defconfig
mips                      malta_kvm_defconfig
mips                     cu1000-neo_defconfig
powerpc                      cm5200_defconfig
arm                           omap1_defconfig
powerpc                 mpc8540_ads_defconfig
mips                          malta_defconfig
alpha                               defconfig
powerpc                    ge_imp3a_defconfig
m68k                       m5475evb_defconfig
arm                       netwinder_defconfig
sh                          rsk7203_defconfig
powerpc                    amigaone_defconfig
mips                      fuloong2e_defconfig
arm                        spear6xx_defconfig
mips                        vocore2_defconfig
nios2                         3c120_defconfig
powerpc                      arches_defconfig
parisc                generic-64bit_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
arm                              alldefconfig
sh                          lboxre2_defconfig
h8300                       h8s-sim_defconfig
mips                        maltaup_defconfig
mips                             allmodconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
sh                             espt_defconfig
powerpc                         wii_defconfig
m68k                                defconfig
arm                            zeus_defconfig
nds32                             allnoconfig
sh                               allmodconfig
parisc                generic-32bit_defconfig
openrisc                    or1ksim_defconfig
sh                     magicpanelr2_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        mvebu_v5_defconfig
powerpc                          allmodconfig
microblaze                      mmu_defconfig
powerpc                      walnut_defconfig
mips                           ip32_defconfig
sh                        edosk7705_defconfig
arm                      footbridge_defconfig
powerpc                     sequoia_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
mips                      maltaaprp_defconfig
riscv                          rv32_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
arm                          lpd270_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210223
x86_64               randconfig-a002-20210223
x86_64               randconfig-a003-20210223
x86_64               randconfig-a005-20210223
x86_64               randconfig-a006-20210223
x86_64               randconfig-a004-20210223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
