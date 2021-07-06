Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4223BC74F
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jul 2021 09:35:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJvV53SHKz2ymV
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Jul 2021 17:35:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=lkp@intel.com; receiver=<UNKNOWN>)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJvV12yYzz3cXX
 for <linux-erofs@lists.ozlabs.org>; Tue,  6 Jul 2021 17:35:19 +1000 (AEST)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="189448201"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; d="scan'208";a="189448201"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2021 00:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; d="scan'208";a="644709033"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2021 00:34:14 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1m0faw-000CnY-6w; Tue, 06 Jul 2021 07:34:14 +0000
Date: Tue, 06 Jul 2021 15:33:20 +0800
From: kernel test robot <lkp@intel.com>
To: Gao Xiang <xiang@kernel.org>
Subject: [xiang-erofs:dev-test] BUILD SUCCESS
 c48349f04faac13303836167def3e44b605c4576
Message-ID: <60e40740.cIqSfTT4/+FZFCtb%lkp@intel.com>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
branch HEAD: c48349f04faac13303836167def3e44b605c4576  erofs: better comment z_erofs_readahead()

elapsed time: 721m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     eseries_pxa_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       ppc64_defconfig
powerpc                     kilauea_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     sbc8548_defconfig
arm                         vf610m4_defconfig
powerpc                      acadia_defconfig
m68k                             allyesconfig
mips                   sb1250_swarm_defconfig
arm                     davinci_all_defconfig
arm                         socfpga_defconfig
mips                     loongson1c_defconfig
mips                        maltaup_defconfig
sparc64                          alldefconfig
xtensa                          iss_defconfig
arm                          pcm027_defconfig
xtensa                    smp_lx200_defconfig
x86_64                              defconfig
h8300                       h8s-sim_defconfig
sh                           se7722_defconfig
m68k                            q40_defconfig
um                               alldefconfig
mips                     cu1830-neo_defconfig
arm                         at91_dt_defconfig
powerpc                 canyonlands_defconfig
openrisc                    or1ksim_defconfig
powerpc                      ppc44x_defconfig
powerpc                    mvme5100_defconfig
sparc                       sparc64_defconfig
mips                    maltaup_xpa_defconfig
sh                             shx3_defconfig
riscv                               defconfig
m68k                             alldefconfig
arc                        nsim_700_defconfig
arm                            dove_defconfig
powerpc                 mpc837x_mds_defconfig
arm                      integrator_defconfig
sh                           se7750_defconfig
sh                                  defconfig
arc                      axs103_smp_defconfig
sh                           se7721_defconfig
powerpc                    ge_imp3a_defconfig
arm                        realview_defconfig
csky                             alldefconfig
xtensa                       common_defconfig
mips                         rt305x_defconfig
sh                         ap325rxa_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                         apsh4a3a_defconfig
mips                        bcm47xx_defconfig
s390                       zfcpdump_defconfig
mips                  cavium_octeon_defconfig
m68k                       m5475evb_defconfig
mips                     cu1000-neo_defconfig
mips                  maltasmvp_eva_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
arm                        magician_defconfig
arm                           tegra_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc885_ads_defconfig
m68k                        mvme16x_defconfig
m68k                         amcore_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210705
i386                 randconfig-a006-20210705
i386                 randconfig-a001-20210705
i386                 randconfig-a003-20210705
i386                 randconfig-a005-20210705
i386                 randconfig-a002-20210705
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a004-20210705
x86_64               randconfig-a002-20210705
x86_64               randconfig-a005-20210705
x86_64               randconfig-a006-20210705
x86_64               randconfig-a003-20210705
x86_64               randconfig-a001-20210705
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
i386                 randconfig-a015-20210705
i386                 randconfig-a016-20210705
i386                 randconfig-a012-20210705
i386                 randconfig-a011-20210705
i386                 randconfig-a014-20210705
i386                 randconfig-a013-20210705
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210705
x86_64               randconfig-a015-20210705
x86_64               randconfig-a014-20210705
x86_64               randconfig-a012-20210705
x86_64               randconfig-a011-20210705
x86_64               randconfig-a016-20210705
x86_64               randconfig-a013-20210705

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
