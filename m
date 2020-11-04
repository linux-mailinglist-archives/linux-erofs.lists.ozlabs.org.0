Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968F2A6599
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Nov 2020 14:55:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CR7Th0yGzzDqbB
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Nov 2020 00:55:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CR7TX0NJCzDqVv
 for <linux-erofs@lists.ozlabs.org>; Thu,  5 Nov 2020 00:55:41 +1100 (AEDT)
IronPort-SDR: KhudccGsqhn3OcF0dchJPv29fJTzOkY/3AAzkl7eXqzJhJ64TUJ5PctzMkEDLeIQIEcL7izVDj
 W4l9iPjbkX7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="230848039"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; d="scan'208";a="230848039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 05:55:38 -0800
IronPort-SDR: LorCKs1oDaWDFYV8gyxq//kKxBPIlVih3ZLsAGt4rlLiREoIWxXrYB7oKQirINznxVJOJnD0nw
 20H8nND/d/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; d="scan'208";a="471230302"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 04 Nov 2020 05:55:37 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1kaJGC-0000wP-OD; Wed, 04 Nov 2020 13:55:36 +0000
Date: Wed, 04 Nov 2020 21:55:36 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: [xiang-erofs:fixes] BUILD SUCCESS
 a30573b3cdc77b8533d004ece1ea7c0146b437a0
Message-ID: <5fa2b2d8.mZ7mlrgYRaIGAFur%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git  fixes
branch HEAD: a30573b3cdc77b8533d004ece1ea7c0146b437a0  erofs: fix setting up pcluster for temporary pages

elapsed time: 724m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
m68k                          amiga_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                 canyonlands_defconfig
arm                        oxnas_v6_defconfig
sh                           se7705_defconfig
mips                           ip28_defconfig
m68k                       m5208evb_defconfig
sh                           se7712_defconfig
arm                        multi_v7_defconfig
powerpc                   motionpro_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
arm                            mmp2_defconfig
mips                      pistachio_defconfig
ia64                            zx1_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
arm                          pxa910_defconfig
mips                      malta_kvm_defconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v5_defconfig
sh                          rsk7203_defconfig
sh                             sh03_defconfig
nios2                            allyesconfig
powerpc                       holly_defconfig
arm                          lpd270_defconfig
sh                           se7722_defconfig
riscv                            allyesconfig
powerpc                      katmai_defconfig
sh                            hp6xx_defconfig
microblaze                      mmu_defconfig
powerpc                    sam440ep_defconfig
sh                          landisk_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     tqm8555_defconfig
arm                          ep93xx_defconfig
arm                        spear3xx_defconfig
powerpc                      chrp32_defconfig
mips                  decstation_64_defconfig
ia64                      gensparse_defconfig
riscv                          rv32_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
sh                          r7785rp_defconfig
powerpc                      ppc64e_defconfig
arm                          iop32x_defconfig
m68k                            mac_defconfig
powerpc                          allyesconfig
mips                  maltasmvp_eva_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
arm                              alldefconfig
arm                     am200epdkit_defconfig
xtensa                          iss_defconfig
arm                           viper_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201104
i386                 randconfig-a006-20201104
i386                 randconfig-a005-20201104
i386                 randconfig-a001-20201104
i386                 randconfig-a002-20201104
i386                 randconfig-a003-20201104
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a015-20201104
i386                 randconfig-a013-20201104
i386                 randconfig-a014-20201104
i386                 randconfig-a016-20201104
i386                 randconfig-a011-20201104
i386                 randconfig-a012-20201104
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201104
x86_64               randconfig-a003-20201104
x86_64               randconfig-a005-20201104
x86_64               randconfig-a002-20201104
x86_64               randconfig-a006-20201104
x86_64               randconfig-a001-20201104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
